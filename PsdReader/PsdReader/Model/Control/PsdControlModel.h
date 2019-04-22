//
//  PsdControlModel.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/17.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PsdLayoutModel;
@class PsdChildModel;
@class PsdBaseMaker;

@interface PsdControlModel : NSObject

/** 不透明度, 不是alpha*/
@property (nonatomic, assign) CGFloat opacity;

/** 文字模型*/
@property (nonatomic, strong) PsdTextModel *text;

/** 原名*/
@property (nonatomic, copy) NSString *originName;

/** 控件变量名*/
@property (nonatomic, copy) NSString *controlVarName;

/** 控件类名*/
@property (nonatomic, copy) NSString *controlClassName;

/** 翻译后的名称*/
@property (nonatomic, copy) NSString *translateName;

/** 控件类型*/
@property (nonatomic, assign) PsdControlType controlType;

/** 自己控件属性代码*/
@property (nonatomic, copy) NSString *controlPropertyString;

/** 调用自己创建方法 : [self prepareTitleLabel]*/
@property (nonatomic, copy) NSMutableString *controlForCallCreateMethodString;

/** 自己控件生成代码 : - (void)prepareTitleLabel{...*/
@property (nonatomic, copy) NSMutableString *controlForCreateSelfString;

/** 事件生成代码*/
@property (nonatomic, copy) NSMutableString *controlForAddEventMethodString;

/** 是否是自定义控件*/
@property (nonatomic, assign) BOOL isCustom;

/** 是否使用了默认名字*/
@property (nonatomic, assign) BOOL isUserDefaultName;

/** 是否可以点击*/
@property (nonatomic, assign) BOOL canClick;

/** 父控件模型*/
@property (nonatomic, weak) PsdControlModel *superModel;

/** 布局模型*/
@property (nonatomic, strong) PsdLayoutModel *layoutModel;

/** 控件创建器*/
@property (nonatomic, strong) PsdBaseMaker *controlMaker;

/**
 根据节点模型初始化

 @param model 节点模型
 @return 控件模型
 */
- (instancetype)initWithChildModel:(PsdChildModel *)model;

/**
 更新控件变量名

 @param valName 变量名
 */
- (void)updateValName:(NSString *)valName;

/**
 重置所有控件字符串
 */
- (void)resetAllControlString;

/**
 改变控件类型

 @param controlType 控件类型
 */
- (void)changeWithControlType:(PsdControlType)controlType;

/**
 由于controlModel和maker互相引用，所以需要手动释放
 */
- (void)handRelease;
@end
