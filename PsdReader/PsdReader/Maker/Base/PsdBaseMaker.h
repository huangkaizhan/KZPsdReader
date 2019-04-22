//
//  PsdBaseMaker.h
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/20.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PsdFileTool.h"
#import "PsdMakerConfigModel.h"
#import "PsdControlModel.h"
//#import "PsdControlModel+iOS.h"
#import "PsdStringFormatter.h"

static NSString *KeySpace = @"    ";

@interface PsdBaseMaker : NSObject

// 配置模型
@property (nonatomic, strong) PsdMakerConfigModel *configModel;

// 控件模型
@property (nonatomic, strong) PsdControlModel *controlModel;

/** 控件名*/
@property (nonatomic, copy) NSString *controlVarName;

// 文件使用demo
@property (nonatomic, copy) NSString *fileDemoName;

// 添加的字符串，默认是self
@property (nonatomic, copy) NSString *addSubViewString;

/** 是否可以点击*/
@property (nonatomic, assign) BOOL canClick;

/** 是否使用过右布局*/
@property (nonatomic, assign) BOOL usedRightLayout;



/**
 根据控件模型初始化

 @param controlModel 控件模型
 @return 创建器
 */
- (instancetype)initWithControlModel:(PsdControlModel *)controlModel;

/**
 创建控件字符串

 @return 字符串
 */
- (NSMutableString *)create;

/**
 创建事件字符串

 @return 字符串
 */
- (NSMutableString *)createEventString;

/**
 创建添加点击手势字符串

 @return addGestureRecognizer...
 */
- (NSMutableString *)createTapGestureEventString;

/**
 创建点击方法事件

 @return - (void....
 */
- (NSMutableString *)createTapMethodEventString;

/**
 调用自己创建方法

 @return [self prepareTitleLabel]
 */
- (NSMutableString *)createCallCreateMethodString;


#pragma mark - 属性

/**
 创建点击block属性字符串

 @return @propert (nonatomic, copy) void(^tapBlock)(DiscusstionView *sender)
 */
- (NSMutableString *)createTapBlockPropertyString;

#pragma mark - 布局
/**
 创建定义UI的方法字符串

 @return - (void)prepareTitleLabel{
 */
- (NSMutableString *)createPrepareUIMethodDefineString;


/**
 创建控件布局字符串

 @return 字符串
 */
- (NSMutableString *)createLayoutString;

/**
 创建控件x布局字符串

 @return 字符串
 */
- (NSMutableString *)createXLayoutString;

/**
 高度布局

 @return make.height.mas_equalTo(...);
 */
- (NSMutableString *)createHeightLayoutString;

/**
 创建相对于父控件的底部约束，一般是最后一个控件需要

 @return make.bottom.mas_equalTo(...).priorityLow();
 */
- (NSMutableString *)createBottomLayoutForSuperControlString;

/**
 创建控件布局字符串

 @param left x
 @param top y
 @param width 宽
 @param height 高
 @return 字符串
 */
- (NSMutableString *)createLayoutStringWithLeft:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height;

/**
 清除所有缓存的字符串
 */
- (void)clearAllCacheString;
@end
