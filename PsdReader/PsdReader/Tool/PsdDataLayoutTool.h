//
//  PsdDataLayoutTool.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/2/5.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PsdDataLayoutTool : NSObject


/**
 处理父控件下的子控件布局

 @param superModelArray 父控件模型数组
 */
+ (void)handleSubControlLayoutWithSuperControlArray:(NSArray *)superModelArray;
@end
