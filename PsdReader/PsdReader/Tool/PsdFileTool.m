//
//  PsdFileTool.m
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/21.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdFileTool.h"

#define PsdRootPath             [NSHomeDirectory() stringByAppendingPathComponent:@"/desktop/PsdReaderResult"]

@interface PsdFileTool()

@end

@implementation PsdFileTool

// 创建子文件夹
+ (NSString *)createDirectoryWithName:(NSString *)name
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [PsdRootPath stringByAppendingPathComponent:name];
    BOOL isDir = false;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (!isDir || !isDirExist) {
        NSError *error;
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
    }
    return path;
}


// 删除根目录
+ (void)deleteRootDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:PsdRootPath error:nil];
    [fileManager createDirectoryAtPath:PsdRootPath withIntermediateDirectories:NO attributes:nil error:nil];
}
@end
