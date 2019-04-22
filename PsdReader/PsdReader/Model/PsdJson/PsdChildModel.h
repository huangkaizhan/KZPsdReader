//
//  PsdGroupModel.h
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/19.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PsdTextModel.h"
#import "PsdMaskModel.h"
//#import "PsdControlModel.h"

/**
 节点模型
 */
@interface PsdChildModel : NSObject

/** 类型 ：是组（group）还是图层（layer）*/
@property (nonatomic, copy) PSDJSON NSString *type;

/** 是否可见 ： 不可见暂时都不管*/
@property (nonatomic, assign) PSDJSON BOOL visible;

/** 不透明度, 不是alpha*/
@property (nonatomic, assign) PSDJSON CGFloat opacity;

/** 渲染模式 ：用不到*/
@property (nonatomic, copy) PSDJSON NSString *blendingMode;

/** 名称 ： 有关命名规范，请参考？*/
@property (nonatomic, copy) PSDJSON NSString *name;

/** 左间距*/
@property (nonatomic, assign) PSDJSON CGFloat left;

/** 右间距 ： 它指的是从0到最右边的距离，类似宽度*/
@property (nonatomic, assign) PSDJSON CGFloat right;

/** 上 ： 相对于psd最上边的距离*/
@property (nonatomic, assign) PSDJSON CGFloat top;

/** 下 ： 从上往下距离，类似高度*/
@property (nonatomic, assign) PSDJSON CGFloat bottom;

/** 宽度*/
@property (nonatomic, assign) PSDJSON CGFloat width;

/** 高度*/
@property (nonatomic, assign) PSDJSON CGFloat height;

/** 子节点*/
@property (nonatomic, strong) PSDJSON NSArray <PsdChildModel *>*children;

/** 文字模型*/
@property (nonatomic, strong) PSDJSON PsdTextModel *text;

/** 遮罩模型 ： 暂时没用*/
@property (nonatomic, strong) PSDJSON PsdMaskModel *mask;



#pragma mark - 附加属性
// 是组还是层
@property (nonatomic, assign) BOOL isLayer;
// 是否是第一组子节点
@property (nonatomic, assign) BOOL isRootModel;
// 属于哪一个根节点
@property (nonatomic, weak) PsdChildModel *rootChildModel;
/** 翻译后的名称*/
@property (nonatomic, copy) NSString *translateName;
/** 翻译成功代码块*/
@property (nonatomic, copy) BlockWithObject_Psd translateCompletionBlock;
@end
