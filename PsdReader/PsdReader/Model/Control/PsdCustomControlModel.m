//
//  PsdCustomControlModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/19.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdCustomControlModel.h"
#import "PsdControlFileMaker.h"

@interface PsdCustomControlModel()

/** 文件代码构造器*/
@property (nonatomic, strong) PsdControlFileMaker *fileMaker;
@end

@implementation PsdCustomControlModel

ArrayM_Create_Two_Psd(subControlModelArray, _subControlModelArray);

- (instancetype)initWithChildModel:(PsdChildModel *)model
{
    self = [super initWithChildModel:model];
    self.isCustom = YES;
    switch (self.controlType) {
        case PsdControlTypeCell:
            _superControlName = Control_Cell_Name_Control;
            break;
        case PsdControlTypeView:
            _superControlName = Control_View_Name_Control;
            break;
        case PsdControlTypeScrollView:
            _superControlName = Control_ScrollView_Name_Control;
            break;
        default:
            _superControlName = @"";
            break;
    }
    return self;
}

- (void)setTranslateName:(NSString *)translateName
{
    [super setTranslateName:translateName];
    // 过滤无效符号
    for (NSInteger i = 0; i < [PsdStandardRepository sharedRepository].invalidValNameArray.count; i++) {
        NSString *number = [PsdStandardRepository sharedRepository].invalidValNameArray[i];
        NSRange range = [translateName rangeOfString:number];
        if (range.length) {
            translateName = [translateName stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    NSString *upperName = [translateName firstCharUpper];
    NSString *prefix = [PsdSettingModel sharedModel].prefix;
    switch (self.controlType) {
        case PsdControlTypeCell:
            _fileName = [NSString stringWithFormat:@"%@%@%@", prefix, upperName, Control_Cell_Name_Upper]; //[upperName stringByAppendingString:Control_Cell_Name_Upper];
            break;
        case PsdControlTypeView:
            _fileName = [NSString stringWithFormat:@"%@%@%@", prefix, upperName, Control_View_Name_Upper]; //[upperName stringByAppendingString:Control_View_Name_Upper];
            break;
        case PsdControlTypeScrollView:
            _fileName = [NSString stringWithFormat:@"%@%@%@", prefix, upperName, Control_ScrollView_Name_Upper]; //[upperName stringByAppendingString:Control_ScrollView_Name_Upper];;
            break;
        default:
            
            break;
    }
}

- (PsdControlFileMaker *)fileMaker
{
    if (!_fileMaker) {
        _fileMaker = [[PsdControlFileMaker alloc] initWithControlModel:self];
    }
    _fileMaker.canClick = self.canClick;
    return _fileMaker;
}

- (NSMutableString *)controlForImportClassString
{
    return [self.fileMaker createImportString];
}

- (NSMutableArray<NSString *> *)labelNameArrayM
{
    if (!_labelNameArrayM) {
        _labelNameArrayM = [NSMutableArray arrayWithArray:[PsdStandardRepository sharedRepository].labelNameArray];
    }
    return _labelNameArrayM;
}

- (NSString *)controlFileString
{
    NSMutableString *controlString = [NSMutableString string];
    // 添加h头文件
    [controlString appendString:[self.fileMaker getDefaultHFileStringWithoutEndString]];
    // block属性
    [controlString appendString:[self.controlMaker createTapBlockPropertyString]];
    [controlString appendString:ForMatterEnd];
    
    NSMutableString *annotationString = [NSMutableString string];
    // 添加m头文件
    [annotationString appendString:[self.fileMaker getMFileAnnotationHeader]];
    
    
    NSMutableString *propertyString = [NSMutableString string];
    NSMutableString *prepareControlString = [NSMutableString string];
    NSMutableString *prepareUIString = [NSMutableString string];
    [prepareUIString appendString:@"\r\n- (void)prepareUI\r\n{\r\n"];
    // 事件
    NSMutableString *eventString = [NSMutableString string];
    if (self.canClick) {
        // 添加事件定义方法
        [eventString appendString:[self.fileMaker createTapMethodEventString]];
    }
    for (PsdControlModel *subControlModel in self.subControlModelArray) {
        if (subControlModel.controlType == PsdControlTypeNone) {
            continue;
        }
        // 属性
        [propertyString appendString:subControlModel.controlPropertyString];
        // 子控件创建方法
        [prepareControlString appendFormat:@"%@", subControlModel.controlForCreateSelfString];
        // 方法调用
        [prepareUIString appendString:subControlModel.controlForCallCreateMethodString];
        // 事件
        [eventString appendString:subControlModel.controlForAddEventMethodString];
        // import
        if ([subControlModel isKindOfClass:[PsdCustomControlModel class]]) {
            if (![annotationString containsString:[NSString stringWithFormat:@"%@.h", ((PsdCustomControlModel *)subControlModel).fileName]]) {
                [annotationString appendString:((PsdCustomControlModel *)subControlModel).controlForImportClassString];
            }
        }
    }
    [prepareUIString appendString:@"}\r\n"];
    // 插入注释
    [controlString appendString:annotationString];
    [controlString appendString:ForMatterInterfaceM(self.fileName)];
    [controlString appendString:propertyString];
    [controlString appendString:ForMatterEnd];
    
    // .m文件的implement不带@end
    [controlString appendString:[self.fileMaker getDefaultMFileImplementationWithoutEndString]];
    // init
    [controlString appendString:[self.fileMaker getInitString]];
    // prepareUI
    [controlString appendString:prepareUIString];
    // 子控件创建方法
    [controlString appendString:prepareControlString];
    // 创建事件
    if (eventString.length) {
        [eventString insertString:@"\r\n#pragma mark - 事件"atIndex:0];
    }
    [controlString appendString:eventString];
    [controlString appendString:ForMatterEnd];
    return controlString;
}

// 更新控件类型名称
- (void)updateClassName:(NSString *)className
{
    if (className.length) {
        _fileName = className;
        [self resetAllControlString];
    }
}

// 更新属性字符串
- (NSString *)updateControlPropertyString
{
    NSString *string = [PsdStringFormatter getPropertyWithClassName:self.fileName controlName:self.controlVarName controlNote:@""];
    return string;
}

// 手动释放
- (void)handRelease
{
    [super handRelease];
    _fileMaker = nil;
}


@end
