//
//  PsdControlFileMaker.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/19.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdBaseMaker.h"

@interface PsdControlFileMaker : PsdBaseMaker

// 文件夹路径
@property (nonatomic, copy) NSString *directoryPath;

#pragma mark - 头文件注释
/**
 获取.h文件头部注释
 
 @return 注释
 */
- (NSMutableString *)getHFileAnnotationHeader;

/**
 获取.m文件头部注释
 
 @return 注释
 */
- (NSMutableString *)getMFileAnnotationHeader;

#pragma mark - h文件字符串
/**
 获取默认.h文件字符串
 
 @return 整个.h字符串
 */
- (NSMutableString *)getDefaultHFileString;

/**
 获取默认.h文件字符串, 不带@end字符串
 
 @return .h字符串
 */
- (NSMutableString *)getDefaultHFileStringWithoutEndString;


#pragma mark - m文件字符串
/**
 获取默认.m文件字符串
 
 @return 整个.m字符串
 */
- (NSMutableString *)getDefaultMFileString;

/**
 获取默认的m文件的interface不带end

 @return 字符串
 */
- (NSMutableString *)getDefaultMFileInterfaceWithoutEndString;

/**
 获取默认的m文件的implementation不带end

 @return @implementtation
 */
- (NSString *)getDefaultMFileImplementationWithoutEndString;

/**
 获取默认.m文件字符串, 不带@end字符串
 
 @return .m字符串
 */
- (NSMutableString *)getDefaultMFileStringWithEndString;

/**
 引入自定义类代码
 
 @return #import "..."
 */
- (NSMutableString *)createImportString;

/**
 获取初始化的代码

 @return initWithFrame/initWithStyle...
 */
- (NSMutableString *)getInitString;

@end
