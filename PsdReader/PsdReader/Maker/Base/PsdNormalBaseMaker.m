//
//  PsdNormalBaseMaker.m
//  PsdReader
//
//  Created by huang kaizhan on 2017/12/31.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdNormalBaseMaker.h"

@implementation PsdNormalBaseMaker

// 获取创建控件的字符串
- (NSMutableString *)getControlStringWithSpace:(NSString *)space
{
    return [self getControlStringWithSpace:space controlName:self.controlModel.controlClassName isFactor:NO];
}

// 获取创建控件的字符串
 - (NSMutableString *)getControlStringWithSpace:(NSString *)space isFactor:(BOOL)isFactor
{
    return [self getControlStringWithSpace:space controlName:self.controlModel.controlClassName isFactor:isFactor];
}

/**
 获取创建控件的字符串
 
 @param space 前置空格
 @param controlName 控件名称
 @return 字符串
 */
- (NSMutableString *)getControlStringWithSpace:(NSString *)space controlName:(NSString *)controlName
{
    return [self getControlStringWithSpace:space controlName:controlName isFactor:NO];
}

/**
 获取创建控件的字符串
 
 @param space 前置空格
 @param controlName 控件名称
 @param isFactor 是否根据屏幕缩放
 @return 字符串
 */
- (NSMutableString *)getControlStringWithSpace:(NSString *)space controlName:(NSString *)controlName isFactor:(BOOL)isFactor
{
    // 子类重写
    return [NSMutableString string];
}
@end
