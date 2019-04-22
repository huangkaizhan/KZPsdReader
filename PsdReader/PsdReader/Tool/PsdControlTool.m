//
//  TransManager.m
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/20.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdControlTool.h"
#import "PsdSmallSquareMaker.h"
#import "PsdDataTool.h"
#import "PsdMakerRepository.h"

@interface PsdControlTool()

@end

@implementation PsdControlTool

static NSString *Key_Error_String = @"它不是个控件，请参照标准规范命名--------\r\n它不是个控件，请参照标准规范命名--------\r\n它不是个控件，请参照标准规范命名--------\r\n它不是个控件，请参照标准规范命名--------\r\n它不是个控件，请参照标准规范命名--------\r\n它不是个控件，请参照标准规范命名--------\r\n它不是个控件，请参照标准规范命名--------\r\n它不是个控件，请参照标准规范命名--------\r\n它不是个控件，请参照标准规范命名--------\r\n它不是个控件，请参照标准规范命名--------\r\n";



// 根据节点模型构建控件字符串
+ (NSString *)createControlWithModel:(PsdChildModel *)model
{
    // 获取对应的构造字符船
    NSMutableString *controlString = [NSMutableString string];
    if (!model.isLayer) {
        // 自定义控件创建
        [[PsdDataTool sharedTool].existFileStringArray removeAllObjects];
        [controlString appendString:[self createCustomControlStringWithModel:model]];
    } else {
        // 单一/子控件控件创建
        [controlString appendString:[self createSubControlStringWithModel:model]];
    }
    // 错误
    if (!controlString.length) {
        [controlString appendString:Key_Error_String];
    }
    //        NSLog(@"controlString = %@", controlString);
    return controlString;
}

// 自定义控件创建
+ (NSString *)createCustomControlStringWithModel:(PsdChildModel *)model
{
    NSMutableString *controlString = [NSMutableString string];
    for (PsdChildModel *childModel in model.children) {
        if (!childModel.isLayer) {
            [controlString appendString:[self createCustomControlStringWithModel:childModel]];
        }
    }
    // 根据根节点名字拿到对应的控件模型
    PsdCustomControlModel *superControlModel = [PsdDataTool sharedTool].customControlDict[model.name];
    if (superControlModel && ![[PsdDataTool sharedTool].existFileStringArray containsObject:superControlModel.fileName]) {
        [controlString appendString:superControlModel.controlFileString];
        [[PsdDataTool sharedTool].existFileStringArray addObject:superControlModel.fileName];
    }
    return controlString;
}

// 单一/子控件控件创建
+ (NSString *)createSubControlStringWithModel:(PsdChildModel *)model
{
    NSMutableString *controlString = [NSMutableString string];
    // 获取对应的控件模型
    PsdControlModel *controlModel = [[PsdDataTool sharedTool] controlModelWithChildModel:model];
    if (controlModel) {
        // 控件创建
        [controlString appendString:controlModel.controlForCreateSelfString];
        // 创建方法
        [controlString appendString:controlModel.controlForAddEventMethodString];
    }
    return controlString;
}
@end
