//
//  PsdNormalBaseMaker.h
//  PsdReader
//
//  Created by huang kaizhan on 2017/12/31.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//  正常控件创建器，如按钮，图片等单一控件

#import "PsdBaseMaker.h"

/**
 正常控件创建器
 */
@interface PsdNormalBaseMaker : PsdBaseMaker

/**
 获取创建控件的字符串
 
 @param space 前置空格
 @return 字符串
 */
- (NSMutableString *)getControlStringWithSpace:(NSString *)space;

/**
 获取创建控件的字符串
 
 @param space 前置空格
 @param controlName 控件名称
 @return 字符串
 */
- (NSMutableString *)getControlStringWithSpace:(NSString *)space controlName:(NSString *)controlName;

/**
 获取创建控件的字符串
 
 @param space 前置空格
 @param isFactor 是否根据屏幕缩放
 @return 字符串
 */
- (NSMutableString *)getControlStringWithSpace:(NSString *)space isFactor:(BOOL)isFactor;

/**
 获取创建控件的字符串
 
 @param space 前置空格
 @param controlName 控件名称
 @param isFactor 是否根据屏幕缩放
 @return 字符串
 */
- (NSMutableString *)getControlStringWithSpace:(NSString *)space controlName:(NSString *)controlName isFactor:(BOOL)isFactor;
@end
