//
//  PsdBaseMaker.m
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/20.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdBaseMaker.h"
#import "PsdCustomControlModel.h"

@interface PsdBaseMaker()
/** 添加点击事件字符串*/
@property (nonatomic, copy) NSMutableString *addTapGestureString;
/** 添加点击事件字符串*/
@property (nonatomic, copy) NSMutableString *addTapGestureMethodDefineString;
/** 添加创建自己事件字符串*/
@property (nonatomic, copy) NSMutableString *createSelfString;
/** 调用创建方法字符串*/
@property (nonatomic, copy) NSMutableString *callCreateMethodString;
/** ui方法定义字符串*/
@property (nonatomic, copy) NSMutableString *prepareUIMethodDefineString;
/** 布局字符串*/
@property (nonatomic, copy) NSMutableString *layoutString;
@end

@implementation PsdBaseMaker

// 根据控件模型初始化
- (instancetype)initWithControlModel:(PsdControlModel *)controlModel
{
    if (self = [super init]) {
        _controlModel = controlModel;
    }
    return self;
}

- (NSString *)controlVarName
{
    return self.controlModel.controlVarName;
}

- (NSMutableString *)addTapGestureString
{
    if (!_addTapGestureString) {
        _addTapGestureString = [NSMutableString string];
        if (self.canClick) {
            if (self.controlModel.isCustom && [self.controlModel isKindOfClass:[PsdCustomControlModel class]] && self.controlModel.controlType != PsdControlTypeButton) {
                // 自定义控件添加block
                [_addTapGestureString appendFormat:@"%@%@.tapBlock = ^(%@ *sender) {%@%@", KeySpace, self.controlVarName, ((PsdCustomControlModel *)self.controlModel).fileName, KeyLineFeed, KeyLineFeed];
                [_addTapGestureString appendFormat:@"%@};%@", KeySpace, KeyLineFeed];
            } else {
                // 子控件直接添加手势
                [_addTapGestureString appendFormat:@"%@UITapGestureRecognizer *%@TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(%@Tap:)];%@",KeySpace,  self.controlVarName, self.controlVarName, KeyLineFeed];
                [_addTapGestureString appendFormat:@"%@[self addGestureRecognizer:%@TapGesture];%@",KeySpace, self.controlVarName, KeyLineFeed];
            }
        }
    }
    return _addTapGestureString;
}

- (NSMutableString *)addTapGestureMethodDefineString
{
    if (!_addTapGestureMethodDefineString) {
        _addTapGestureMethodDefineString = [NSMutableString string];
        if (self.canClick) {
            // 自定义的控件使用block回调，所以不添加
            if (!self.controlModel.isCustom) {
                [_addTapGestureMethodDefineString appendFormat:@"%@// <#zhushi#>%@",KeyLineFeed, KeyLineFeed];
                [_addTapGestureMethodDefineString appendFormat:@"- (void)%@Tap:(UITapGestureRecognizer *)gesture%@{%@%@}%@",self.controlVarName, KeyLineFeed, KeyLineFeed, KeyLineFeed, KeyLineFeed];
            }
        }
    }
    return _addTapGestureMethodDefineString;
}

// 创建点击block属性字符串
- (NSMutableString *)createTapBlockPropertyString
{
    NSMutableString *string = [NSMutableString string];
    if (self.canClick && self.controlModel.isCustom && self.controlModel.controlType != PsdControlTypeButton && [self.controlModel isKindOfClass:[PsdCustomControlModel class]]) {
        [string appendFormat:@"/** <#zhushi#>*/%@", KeyLineFeed];
        [string appendFormat:@"@property (nonatomic, copy) void(^tapBlock)();%@", KeyLineFeed];
    }
    return string;
}

- (NSMutableString *)createSelfString
{
    if (!_createSelfString) {
        _createSelfString = [self createEventString];
        [_createSelfString appendString:[self createLayoutString]];
    }
    return _createSelfString;
}

- (NSMutableString *)callCreateMethodString
{
    if (!_callCreateMethodString) {
        _callCreateMethodString = [NSMutableString string];
        NSString *methodName = [NSString stringWithFormat:@"prepare%@", [self.controlVarName firstCharUpper]];
        [_callCreateMethodString appendFormat:@"%@%@[self %@];%@%@",KeyLineFeed, KeySpace, methodName, KeyLineFeed, KeyLineFeed];
    }
    return _callCreateMethodString;
}

- (NSMutableString *)prepareUIMethodDefineString
{
    if (!_prepareUIMethodDefineString) {
        _prepareUIMethodDefineString = [NSMutableString string];
        NSString *methodName = [NSString stringWithFormat:@"prepare%@", [self.controlVarName firstCharUpper]];
        [_prepareUIMethodDefineString appendFormat:@"%@- (void)%@%@{%@",KeyLineFeed, methodName, KeyLineFeed, KeyLineFeed];
    }
    return _prepareUIMethodDefineString;
}

- (NSString *)addSubViewString
{
    NSString *control = self.controlModel.superModel.controlType == PsdControlTypeCell ? @".contentView" : @"";
    return [NSString stringWithFormat:@"%@[self%@ addSubview:%@];%@", KeySpace, control, self.controlVarName, KeyLineFeed];
}

- (NSMutableString *)layoutString
{
    if (!_layoutString) {
        _layoutString = [NSMutableString string];
        [_layoutString appendFormat:@"%@self.%@ = %@;%@",KeySpace, self.controlVarName, self.controlVarName, KeyLineFeed];
        [_layoutString appendString:self.addSubViewString];
        [_layoutString appendFormat:@"%@__weak typeof (self) weakSelf = self;%@", KeySpace, KeyLineFeed];
        [_layoutString appendFormat:@"%@[%@ mas_makeConstraints:^(MASConstraintMaker *make) {%@", KeySpace, self.controlVarName, KeyLineFeed];
        if (self.controlModel.layoutModel.isEqualEdge) {
            // edge
            [_layoutString appendString:[self layoutEdgeString]];
        } else {
            // x布局
            [_layoutString appendString:[self createXLayoutString]];
            // y布局
            [_layoutString appendString:[self createYLayoutString]];
            // 宽/右布局
            [_layoutString appendString:[self createWidthLayoutString]];
            // 高度布局
            [_layoutString appendString:[self createHeightLayoutString]];
            // 底部布局
            [_layoutString appendString:[self createBottomLayoutForSuperControlString]];
        }
        [_layoutString appendFormat:@"%@}];%@", KeySpace, KeyLineFeed];
    }
    return _layoutString;
}

- (NSString *)layoutEdgeString
{
    return [NSString stringWithFormat:@"%@%@make.edges.equalTo(weakSelf);%@", KeySpace, KeySpace, KeyLineFeed];
}

// 创建控件x布局字符串
- (NSMutableString *)createXLayoutString
{
    NSMutableString *xLayoutString = [NSMutableString string];
    if (self.controlModel.layoutModel.isHorizontalInSuper) {
        [xLayoutString appendFormat:@"%@%@make.centerX.equalTo(weakSelf);%@",KeySpace, KeySpace, KeyLineFeed];
    } else if (self.controlModel.layoutModel.alignHorizontalModel) {
        [xLayoutString appendFormat:@"%@%@make.centerX.equalTo(weakSelf.%@);%@",KeySpace, KeySpace, self.controlModel.layoutModel.alignHorizontalModel.controlVarName, KeyLineFeed];
    } else if (self.controlModel.layoutModel.alignLeftModel) {
        [xLayoutString appendFormat:@"%@%@make.left.equalTo(weakSelf.%@);%@",KeySpace, KeySpace, self.controlModel.layoutModel.alignLeftModel.controlVarName, KeyLineFeed];
    } else if (self.controlModel.layoutModel.alignRightModel) {
        [xLayoutString appendFormat:@"%@%@make.right.equalTo(weakSelf.%@);%@",KeySpace, KeySpace, self.controlModel.layoutModel.alignRightModel.controlVarName, KeyLineFeed];
    } else if (self.controlModel.layoutModel.userRightLayout) {
        self.usedRightLayout = YES;
        if (self.controlModel.layoutModel.relativeRightModel) {
            [xLayoutString appendFormat:@"%@%@make.right.equalTo(weakSelf.%@.mas_left).offset(%.1f%@);%@",KeySpace, KeySpace, self.controlModel.layoutModel.relativeRightModel.controlVarName, self.controlModel.layoutModel.iOS_relativeRight, FormatterLayoutFactor, KeyLineFeed];
        } else {
            [xLayoutString appendFormat:@"%@%@make.right.mas_equalTo(%.1f%@);%@", KeySpace, KeySpace, -self.controlModel.layoutModel.iOS_right, FormatterLayoutFactor, KeyLineFeed];
        }
    } else if (self.controlModel.layoutModel.relativeLeftModel) {
        [xLayoutString appendFormat:@"%@%@make.left.equalTo(weakSelf.%@.mas_right).offset(%.1f%@);%@",KeySpace, KeySpace, self.controlModel.layoutModel.relativeLeftModel.controlVarName, self.controlModel.layoutModel.iOS_relativeLeft, FormatterLayoutFactor, KeyLineFeed];
    } else {
        [xLayoutString appendFormat:@"%@%@make.left.mas_equalTo(%.1f%@);%@", KeySpace, KeySpace, self.controlModel.layoutModel.iOS_left, FormatterLayoutFactor, KeyLineFeed];
    }
    return xLayoutString;
}

- (NSMutableString *)createWidthLayoutString
{
    NSMutableString *widthLayoutString = [NSMutableString string];
    // 1. 这个控件有可能是单行控件
    // 2. 这个控件有可能是单行最后一个右边布局的控件
    if (self.usedRightLayout) {
        [widthLayoutString appendFormat:@"%@%@make.width.mas_equalTo(%.1f%@);%@", KeySpace, KeySpace, self.controlModel.layoutModel.iOS_width, FormatterLayoutFactor, KeyLineFeed];
    } else  if (self.controlModel.layoutModel.isSingleLineControl || (self.controlModel.layoutModel.userRightLayout && !self.controlModel.layoutModel.relativeRightModel)) {
        [widthLayoutString appendFormat:@"%@%@make.right.mas_equalTo(%.1f%@);%@", KeySpace, KeySpace, -self.controlModel.layoutModel.iOS_right, FormatterLayoutFactor, KeyLineFeed];
    } else {
        [widthLayoutString appendFormat:@"%@%@make.width.mas_equalTo(%.1f%@);%@", KeySpace, KeySpace, self.controlModel.layoutModel.iOS_width, FormatterLayoutFactor, KeyLineFeed];
    }
    return widthLayoutString;
}

// 高度布局
- (NSMutableString *)createHeightLayoutString
{
    NSMutableString *heightLayoutString = [NSMutableString string];
    [heightLayoutString appendFormat:@"%@%@make.height.mas_equalTo(%.1f%@);%@", KeySpace, KeySpace, self.controlModel.layoutModel.iOS_height, FormatterLayoutFactor, KeyLineFeed];
    return heightLayoutString;
}

// 创建控件x布局字符串
- (NSMutableString *)createYLayoutString
{
    NSMutableString *yLayoutString = [NSMutableString string];
    if (self.controlModel.layoutModel.isVerticalInSuper) {
        [yLayoutString appendFormat:@"%@%@make.centerY.equalTo(weakSelf);%@",KeySpace, KeySpace, KeyLineFeed];
    } else if (self.controlModel.layoutModel.alignVerticalModel) {
        [yLayoutString appendFormat:@"%@%@make.centerY.equalTo(weakSelf.%@);%@",KeySpace, KeySpace, self.controlModel.layoutModel.alignVerticalModel.controlVarName, KeyLineFeed];
    } else if (self.controlModel.layoutModel.alignTopModel) {
        [yLayoutString appendFormat:@"%@%@make.top.equalTo(weakSelf.%@);%@",KeySpace, KeySpace, self.controlModel.layoutModel.alignTopModel.controlVarName, KeyLineFeed];
    } else if (self.controlModel.layoutModel.alignBottomModel) {
        [yLayoutString appendFormat:@"%@%@make.bottom.equalTo(weakSelf.%@);%@",KeySpace, KeySpace, self.controlModel.layoutModel.alignBottomModel.controlVarName, KeyLineFeed];
    } else if (self.controlModel.layoutModel.relativeTopModel) {
//        CGFloat top = (self.controlModel.layoutModel.top - self.controlModel.layoutModel.relativeTopModel.layoutModel.maxY) * 0.5;
        [yLayoutString appendFormat:@"%@%@make.top.equalTo(weakSelf.%@.mas_bottom).offset(%.1f%@);%@",KeySpace, KeySpace, self.controlModel.layoutModel.relativeTopModel.controlVarName, self.controlModel.layoutModel.iOS_relativeTop, FormatterLayoutFactor, KeyLineFeed];
    } else {
        [yLayoutString appendFormat:@"%@%@make.top.mas_equalTo(%.1f%@);%@", KeySpace, KeySpace, self.controlModel.layoutModel.iOS_top,FormatterLayoutFactor,  KeyLineFeed];
    }
    return yLayoutString;
}

// 创建相对于父控件的底部约束，一般是最后一个控件需要
- (NSMutableString *)createBottomLayoutForSuperControlString
{
    NSMutableString *bottomLayoutString = [NSMutableString string];
    if (self.controlModel.layoutModel.isLastControl) {
        CGFloat bottom = (self.controlModel.superModel.layoutModel.bottom - self.controlModel.layoutModel.bottom) * 0.5;
        [bottomLayoutString appendFormat:@"%@%@make.bottom.mas_equalTo(%.1f%@).priorityLow();%@", KeySpace, KeySpace, bottom, FormatterLayoutFactor, KeyLineFeed];
    }
    return bottomLayoutString;
}


- (NSMutableString *)create
{
    return self.createSelfString;
}

// 创建事件字符串
- (NSMutableString *)createEventString
{
    NSMutableString *eventString = [self createTapGestureEventString];
    return eventString;
}

// 添加点击手势字符串
- (NSMutableString *)createTapGestureEventString
{
    return self.addTapGestureString;
}

// 点击方法事件
- (NSMutableString *)createTapMethodEventString
{
    return self.addTapGestureMethodDefineString;
}

// 调用自己创建方法
- (NSMutableString *)createCallCreateMethodString
{
    return self.callCreateMethodString;
}

// 创建定义UI的方法字符串
- (NSMutableString *)createPrepareUIMethodDefineString
{
    return self.prepareUIMethodDefineString;
}


- (NSMutableString *)createLayoutString
{
    return self.layoutString;
}

- (NSMutableString *)createLayoutStringWithLeft:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height
{
    NSMutableString *layoutString = [NSMutableString string];
    [layoutString appendFormat:@"%@self.%@ = %@;%@",KeySpace, self, self.controlVarName, KeyLineFeed];
    [layoutString appendFormat:@"%@[self addSubview:%@];%@", KeySpace, self.controlVarName, KeyLineFeed];
    [layoutString appendFormat:@"%@__weak typeof (self) weakSelf = self;%@", KeySpace, KeyLineFeed];
    [layoutString appendFormat:@"%@[%@ mas_makeConstraints:^(MASConstraintMaker *make) {%@", KeySpace, self.controlVarName, KeyLineFeed];
    [layoutString appendFormat:@"%@%@make.left.mas_equalTo(%.1f);%@", KeySpace, KeySpace, left, KeyLineFeed];
    [layoutString appendFormat:@"%@%@make.top.mas_equalTo(%.1f);%@", KeySpace, KeySpace,top, KeyLineFeed];
    [layoutString appendFormat:@"%@%@make.width.mas_equalTo(%.1f);%@", KeySpace, KeySpace, width, KeyLineFeed];
    [layoutString appendFormat:@"%@%@make.height.mas_equalTo(%.1f);%@", KeySpace, KeySpace, height, KeyLineFeed];
    [layoutString appendFormat:@"%@}];%@", KeySpace, KeyLineFeed];
    return layoutString;
}

/**
 清除所有缓存的字符串
 */
- (void)clearAllCacheString
{
    _addTapGestureString = nil;
    _addTapGestureMethodDefineString = nil;
    _createSelfString = nil;
    _callCreateMethodString = nil;
    _prepareUIMethodDefineString = nil;
    _layoutString = nil;
}












@end
