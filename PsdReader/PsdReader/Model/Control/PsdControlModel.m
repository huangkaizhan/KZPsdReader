//
//  PsdControlModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/17.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdControlModel.h"
#import "PsdBaseMaker.h"
#import "PsdMakerRepository.h"
#import "PsdStringFormatter.h"
#import "PsdCustomControlModel.h"
#import "PsdLayoutModel.h"

@interface PsdControlModel()

@end

@implementation PsdControlModel

MJCodingImplementation

ObjectCreate_Psd(PsdLayoutModel, layoutModel, _layoutModel);

/**
 根据节点模型初始化
 
 @param model 节点模型
 @return 控件模型
 */
- (instancetype)initWithChildModel:(PsdChildModel *)model
{
    if (self = [super init]) {
        self.layoutModel.originLeft = model.left;
        self.layoutModel.originRight = model.right;
        self.layoutModel.originTop = model.top;
        self.layoutModel.originHeight = model.height;
        self.layoutModel.originBottom = model.bottom;
        self.layoutModel.originWidth = model.width;
        self.layoutModel.width = self.layoutModel.originWidth;
        self.layoutModel.height = self.layoutModel.originHeight;
        self.opacity = model.opacity;
        self.text = model.text;
        if (model.translateName.length) {
            self.translateName = model.translateName;
        }
        self.originName = model.name;
        // 处理事件
        [self handleControlEventWithModel:model];
        // 处理控件类型
        [self handleControlTypeWithModel:model];
        // 默认名
        [self initControlDefaultValName];
    }
    return self;
}

- (void)initControlDefaultValName
{
    WeakSelf_Psd
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 加个时间戳好了
        NSInteger time = (NSInteger)[[NSDate date] timeIntervalSince1970];
        if (!weakSelf.controlVarName.length) {
            switch (weakSelf.controlType) {
                case PsdControlTypeCell:
                    _controlVarName = [NSString stringWithFormat:@"%@%zd", Control_Cell_Name_Lower, time];
                    break;
                case PsdControlTypeView:
                    _controlVarName = [NSString stringWithFormat:@"%@%zd", Control_View_Name_Lower, time];
                    break;
                case PsdControlTypeImageView:
                    _controlVarName = [NSString stringWithFormat:@"%@%zd", Control_ImageView_Name_Lower, time];
                    break;
                case PsdControlTypeLabel:
                    _controlVarName = [NSString stringWithFormat:@"%@%zd", Control_Label_Name_Lower, time];
                    break;
                case PsdControlTypeButton:
                    _controlVarName = [NSString stringWithFormat:@"%@%zd", Control_Button_Name_Lower, time];
                    break;
                case PsdControlTypeTextField:
                    _controlVarName = [NSString stringWithFormat:@"%@%zd", Control_TextField_Name_Lower, time];
                    break;
                case PsdControlTypeScrollView:
                    _controlVarName = [NSString stringWithFormat:@"%@%zd", Control_ScrollView_Name_Lower, time];
                    break;
                case PsdControlTypeNone:
                    _controlVarName = [NSString stringWithFormat:@"不是控件%zd", time];
                    break;
                default:
                    NSAssert(1 == 2, @"写少了控件枚举判断啦");
                    break;
            }
        }
    });
}

- (void)setSuperModel:(PsdControlModel *)superModel
{
    _superModel = superModel;
    if (superModel) {
        CGFloat left = self.layoutModel.originLeft - superModel.layoutModel.originLeft;
        CGFloat width = self.layoutModel.originWidth;
        // 左边小于0，证明左移了
        if (left < 0) {
            width += left; //修改宽度
            left = 0; //重置为0
        }
        // 右边小于0，证明右移了
        CGFloat right = superModel.layoutModel.originRight - self.layoutModel.originRight;
        if (right < 0) {
            width += right;
            right = 0;
        }
        // 宽度,判断有无超出标准宽度
        if (width > superModel.layoutModel.width) {
            width = superModel.layoutModel.width;
        }
        CGFloat top = self.layoutModel.originTop - superModel.layoutModel.originTop;
        CGFloat height = self.layoutModel.originHeight;
        // 顶部小于0，证明上移了
        if (top < 0) {
            height += top;
            top = 0;
        }
        // 底部小于0，证明下移了
        CGFloat bottom = superModel.layoutModel.originBottom - self.layoutModel.originBottom;
        if (bottom < 0) {
            height += bottom;
            bottom = 0;
        }
        // 父控件高度
        if (height > superModel.layoutModel.height) {
            height = superModel.layoutModel.height;
        }
        self.layoutModel.left = left;
        self.layoutModel.right = right;
        self.layoutModel.top = top;
        self.layoutModel.bottom = bottom;
        self.layoutModel.width = width;
        self.layoutModel.height = height;
        if (self.layoutModel.width == superModel.layoutModel.width) {
            self.layoutModel.isEqualSuperWidth = YES;
        }
        if (self.layoutModel.height == superModel.layoutModel.height) {
            self.layoutModel.isEqualSuperHeight = YES;
        }
    }
}

- (void)setTranslateName:(NSString *)translateName
{
    if (!translateName) {
        translateName = @"";
    }
    // 使用了默认名称就不要翻译名了
    if (self.isUserDefaultName) {
        _translateName = translateName;
        return;
    }
    // 过滤无效符号
    for (NSInteger i = 0; i < [PsdStandardRepository sharedRepository].invalidValNameArray.count; i++) {
        NSString *number = [PsdStandardRepository sharedRepository].invalidValNameArray[i];
        NSRange range = [translateName rangeOfString:number];
        if (range.length) {
            translateName = [translateName stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    switch (self.controlType) {
        case PsdControlTypeCell:
            _controlVarName = [translateName stringByAppendingString:Control_Cell_Name_Upper];
            break;
        case PsdControlTypeView:
        {
            // 如果是系统已经存在的变量名，那么要更换名字
            for (NSString *key in [PsdStandardRepository sharedRepository].systemValNameDict) {
                if ([translateName isEqualToString:key]) {
                    translateName = [PsdStandardRepository sharedRepository].systemValNameDict[key];
                    break;
                }
            }
            _controlVarName = [translateName stringByAppendingString:Control_View_Name_Upper];
        }
            break;
        case PsdControlTypeImageView:
            _controlVarName = [translateName stringByAppendingString:Control_ImageView_Name_Upper];
            break;
        case PsdControlTypeLabel:
        {
            _controlVarName = [translateName stringByAppendingString:Control_Label_Name_Upper];
        }
            break;
        case PsdControlTypeButton:
            _controlVarName = [translateName stringByAppendingString:Control_Button_Name_Upper];
            break;
        case PsdControlTypeTextField:
            _controlVarName = [translateName stringByAppendingString:Control_TextField_Name_Upper];
            break;
        case PsdControlTypeScrollView:
            _controlVarName = [translateName stringByAppendingString:Control_ScrollView_Name_Upper];
            break;
        case PsdControlTypeNone:
            _controlVarName = translateName;
            break;
        default:
            NSAssert(1 == 2, @"写少了控件枚举判断啦");
            break;
    }
    _translateName = translateName;
    _controlVarName = [_controlVarName firstCharLower];
    [self resetAllControlString];
}

- (NSString *)controlClassName
{
    switch (self.controlType) {
        case PsdControlTypeCell:
            return Control_Cell_Name_Control;
        case PsdControlTypeView:
            return Control_View_Name_Control;
        case PsdControlTypeImageView:
            return Control_ImageView_Name_Control;
        case PsdControlTypeLabel:
            return Control_Label_Name_Control;
        case PsdControlTypeButton:
            return Control_Button_Name_Control;
        case PsdControlTypeScrollView:
            return Control_ScrollView_Name_Control;
        case PsdControlTypeTextField:
            return Control_TextField_Name_Control;
        case PsdControlTypeNone:
            return @"";
        default:
            NSAssert(1 == 2, @"写少了控件枚举判断啦");
            return @"";
    }
}

// 处理控件类型
- (void)handleControlTypeWithModel:(PsdChildModel *)model
{
    // 默认控件类型，如果是层，那么有可能不创建了，如果是组，那么默认为view
    PsdControlType type = model.isRootModel ? PsdControlTypeView : PsdControlTypeNone;
    PsdStandardRepository *repository = [PsdStandardRepository sharedRepository];
    // 遍历规范仓库中的所有控件规范，算出控件类型
    for (PsdStandarControlModel *controlModel in repository.controlModelArray) {
        if ([model.name containsString:controlModel.findIdentify]) {
            type = controlModel.type;
            break;
        }
    }
    // 因为psd文件中有文字的话text会是个对象，说明是文字，或者是按钮
    if (type != PsdControlTypeButton && model.text) {
        type = PsdControlTypeLabel;
    }
    // 如果是文字并且可以点击，恭喜，升级为按钮
    if (type == PsdControlTypeLabel && self.canClick) {
        type = PsdControlTypeButton;
    }
    self.controlType = type;
    self.layoutModel.controlType = type;
}

- (void)handleControlEventWithModel:(PsdChildModel *)model
{
    // 点击事件
    if ([model.name containsString:[PsdStandardRepository sharedRepository].clickKey]) {
        self.canClick = YES;
    }
}

- (PsdBaseMaker *)controlMaker
{
    if (!_controlMaker) {
        _controlMaker = [PsdMakerRepository makerWithControlModel:self];
    }
    _controlMaker.canClick = self.canClick;
    return _controlMaker;
}

- (NSString *)controlPropertyString
{
    return [self updateControlPropertyString];;
}

- (NSMutableString *)controlForCallCreateMethodString
{
    return [self.controlMaker createCallCreateMethodString];
}

- (NSMutableString *)controlForCreateSelfString
{
    if (!_controlForCreateSelfString) {
        _controlForCreateSelfString = [self.controlMaker create];
    }
    return [self.controlMaker create];
}

- (NSMutableString *)controlForAddEventMethodString
{
    if (!_controlForAddEventMethodString) {
        _controlForAddEventMethodString = [self.controlMaker createTapMethodEventString];
    }
    return [self.controlMaker createTapMethodEventString];
}

// 更新控件变量名
- (void)updateValName:(NSString *)valName
{
    if (valName.length) {
        _controlVarName = valName;
        [self resetAllControlString];
    }
}

// 更新属性字符串
- (NSString *)updateControlPropertyString
{
    NSString *string = [PsdStringFormatter getPropertyWithControlType:self.controlType controlName:self.controlVarName controlNote:@""];
    return string;
}

// 重置所有控件字符串
- (void)resetAllControlString
{
    [_controlMaker clearAllCacheString];
}

// 改变控件类型
- (void)changeWithControlType:(PsdControlType)controlType
{
    if (controlType == self.controlType) {
        return;
    }
    _controlType = controlType;
    // 重置所有控件字符串
    [self resetAllControlString];
    [self setTranslateName:_translateName];
}

// 由于controlModel和maker互相引用，所以需要手动释放
- (void)handRelease
{
    _controlMaker = nil;
}
@end
