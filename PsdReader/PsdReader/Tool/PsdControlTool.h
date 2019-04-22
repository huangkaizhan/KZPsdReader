//
//  TransManager.h
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/20.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PsdChildModel.h"


/**
 转换工具
 */
@interface PsdControlTool : NSObject


/**
 根据节点模型构建控件字符串

 @param model 节点模型
 @return 控件字符串
 */
+ (NSString *)createControlWithModel:(PsdChildModel *)model;

@end
