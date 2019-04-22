//
//  PsdLayoutModel.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/31.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//


/*
 布局规则
 
 算法 ：
    1. 先分行数组，如果控件在同一行，那么把它们分为一组
    2. 行数组分好后，按x值从小到大排序，也就是从左往右排
    3. 再把行数组分为左数组和右数组，左数组是从左往右排，右数组是从右往左排，它们的区分规则是，相对距离超过20的视为右布局
    4. 遍历赋值各自的属性
 
  布局 ：
    1. 如果控件宽高和父类控件宽高相等，那么它的布局则是edge相等于父控件
    2. 如果控件相对于父控件水平或者垂直居中，那么它的centerX或centerY则相等于父控件
    3. x值 -> 如果是行的左数组第一个，那么x相对父控件，后面的相对于左数组的前一个
    4. x值 -> 如果是行的右数组第一个，那么x相对父控件，后面的相对于右数组的前一个
    5. y值 -> 第一个行数组第一个值，y值相对于父控件，后面的判断有无跟前面的控件center值一直，如果有，则垂直对齐，没有则相对于前一个控件做布局
    5. y值 -> 后面的行数组第一个，都是相对于上一个行数组最后一个
 */

#import <Foundation/Foundation.h>
@class PsdControlModel;

@interface PsdLayoutModel : NSObject

/** 控件类型*/
@property (nonatomic, assign) PsdControlType controlType;

#pragma mark - 相对于整个psd的布局属性
/** 左间距*/
@property (nonatomic, assign) CGFloat originLeft;

/** 右间距 ： 它指的是从0到最右边的距离，类似宽度*/
@property (nonatomic, assign) CGFloat originRight;

/** 上 ： 相对于psd最上边的距离*/
@property (nonatomic, assign) CGFloat originTop;

/** 下 ： 从上往下距离，类似高度*/
@property (nonatomic, assign) CGFloat originBottom;

/** 宽度*/
@property (nonatomic, assign) CGFloat originWidth;

/** 高度*/
@property (nonatomic, assign) CGFloat originHeight;


#pragma mark - 相对于父控件的布局属性
/** 左间距*/
@property (nonatomic, assign) CGFloat left;

/** 右间距 ： 它指的是从0到最右边的距离，类似宽度*/
@property (nonatomic, assign) CGFloat right;

/** 上 ： 相对于psd最上边的距离*/
@property (nonatomic, assign) CGFloat top;

/** 下 ： 从上往下距离，类似高度*/
@property (nonatomic, assign) CGFloat bottom;

/** 宽度*/
@property (nonatomic, assign) CGFloat width;

/** 高度*/
@property (nonatomic, assign) CGFloat height;

/** 中心Y ：maxY - height * 0.5*/
@property (nonatomic, assign) CGFloat centerY;

/** 中心X ：maxX - width * 0.5*/
@property (nonatomic, assign) CGFloat centerX;

/** 最大x ：left + width*/
@property (nonatomic, assign) CGFloat maxX;

/** 最大y ：top + height*/
@property (nonatomic, assign) CGFloat maxY;

/** 是否相对于父控件水平居中*/
@property (nonatomic, assign) BOOL isHorizontalInSuper;

/** 是否相对于父控件垂直居中*/
@property (nonatomic, assign) BOOL isVerticalInSuper;

/** 是否跟父控件等宽*/
@property (nonatomic, assign) BOOL isEqualSuperWidth;

/** 是否跟父控件等高*/
@property (nonatomic, assign) BOOL isEqualSuperHeight;

/** 是否启动edge相等*/
@property (nonatomic, assign) BOOL isEqualEdge;

/** 是否使用右布局*/
@property (nonatomic, assign) BOOL userRightLayout;

/** 是否使用底部布局*/
@property (nonatomic, assign) BOOL userBottomLayout;

#pragma mark - 相对于平级控件的布局属性
/** 相对顶部间距*/
@property (nonatomic, assign) CGFloat relativeTop;

/** 相对顶部间距模型*/
@property (nonatomic, weak) PsdControlModel *relativeTopModel;

/** 相对底部间距*/
@property (nonatomic, assign) CGFloat relativeBottom;

/** 相对底部间距模型*/
@property (nonatomic, weak) PsdControlModel *relativeBottomModel;

/** 相对左边间距*/
@property (nonatomic, assign) CGFloat relativeLeft;

/** 相对左边间距模型*/
@property (nonatomic, weak) PsdControlModel *relativeLeftModel;

/** 相对右边间距*/
@property (nonatomic, assign) CGFloat relativeRight;

/** 相对右边间距模型*/
@property (nonatomic, weak) PsdControlModel *relativeRightModel;


#pragma mark - 对齐模型
/** 顶部对齐模型*/
@property (nonatomic, weak) PsdControlModel *alignTopModel;

/** 底部对齐模型*/
@property (nonatomic, weak) PsdControlModel *alignBottomModel;

/** 左对齐模型*/
@property (nonatomic, weak) PsdControlModel *alignLeftModel;

/** 右对齐模型*/
@property (nonatomic, weak) PsdControlModel *alignRightModel;

/** 相对水平居中模型*/
@property (nonatomic, weak) PsdControlModel *alignHorizontalModel;

/** 相对水平居中模型*/
@property (nonatomic, weak) PsdControlModel *alignVerticalModel;


#pragma mark - 其它属性
/** 是否是单行控件*/
@property (nonatomic, assign) BOOL isSingleLineControl;
/** 是否是最后一个控件*/
@property (nonatomic, assign) BOOL isLastControl;
@end

// --------------------------------------------------上面的属性，不区分机型系统等，都是psd的数据计算出来的原始数据---------------------------------------

/**
 iOS布局属性，一般来说都是两倍，因为psd是px，ios是pt
 */
@interface PsdLayoutModel (iOS)

#pragma mark - 相对于父控件的布局属性
/** 左间距, */
- (CGFloat)iOS_left;

/** 右间距 ： 它指的是从0到最右边的距离，类似宽度*/
- (CGFloat)iOS_right;

/** 上 ： 相对于psd最上边的距离*/
- (CGFloat)iOS_top;

///** 顶部对齐偏移量*/
//- (CGFloat)iOS_alignTop;

/** 下 ： 从上往下距离，类似高度*/
- (CGFloat)iOS_bottom;

///** 底部对齐偏移量*/
//- (CGFloat)iOS_alignBottom;

/** 宽度*/
- (CGFloat)iOS_width;

/** 高度*/
- (CGFloat)iOS_height;

#pragma mark - 相对于平级控件的布局属性

/** 相对顶部间距*/
- (CGFloat)iOS_relativeTop;

/** 相对左边间距*/
- (CGFloat)iOS_relativeLeft;

/** 相对右边间距*/
- (CGFloat)iOS_relativeRight;

@end
