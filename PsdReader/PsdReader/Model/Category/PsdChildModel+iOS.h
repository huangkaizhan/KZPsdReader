//
//  PsdChildModel+iOS.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/16.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdChildModel.h"


/**
 把所有的布局属性/2倍，因为psd是px，ios是pt
 */
@interface PsdChildModel (iOS)

/** 左间距, */
- (CGFloat)iOS_left;

/** 右间距 ： 它指的是从0到最右边的距离，类似宽度*/
- (CGFloat)iOS_right;

/** 上 ： 相对于psd最上边的距离*/
- (CGFloat)iOS_top;

/** 下 ： 从上往下距离，类似高度*/
- (CGFloat)iOS_bottom;

/** 宽度*/
- (CGFloat)iOS_width;

/** 高度*/
- (CGFloat)iOS_height;
@end
