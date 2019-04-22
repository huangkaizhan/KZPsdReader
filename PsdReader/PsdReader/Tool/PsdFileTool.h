//
//  PsdFileTool.h
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/21.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 文件工具, 默认总目录存在桌面的PsdReaderResult文件夹，每次生成会清零
 */
@interface PsdFileTool : NSObject


/**
 创建子文件夹

 @param name 子文件夹名称
 @return 路径
 */
+ (NSString *)createDirectoryWithName:(NSString *)name;

// 删除根目录
+ (void)deleteRootDirectory;
@end
