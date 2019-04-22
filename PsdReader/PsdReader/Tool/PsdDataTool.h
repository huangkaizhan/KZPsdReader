//
//  PsdDataTool.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/15.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton_lib.h"
#import "PsdRootModel.h"
#import "PsdCustomControlModel.h"

/**
 数据工具， 处理数据
 */
@interface PsdDataTool : NSObject

SingletonH_lib(Tool);

/** 元数据*/
@property (nonatomic, strong, readonly) PsdRootModel *dataModel;
/** 自定义控件节点数组*/
@property (nonatomic, strong) NSMutableArray <PsdCustomControlModel *>*customControlArray;
/** 自定义控件节点字典*/
@property (nonatomic, strong) NSMutableDictionary <NSString *, PsdCustomControlModel *>*customControlDict;
/** 所有控件节点字典*/
@property (nonatomic, strong) NSMutableDictionary <NSString *, PsdControlModel *>*subControlDict;
/** 已存在的控件文件*/
@property (nonatomic, strong) NSMutableArray *existFileStringArray;
/**
 根据json字典数据初始化

 @param dict 字典
 */
- (void)setupWithJsonDict:(id)dict;


/**
 根据节点模型获取对应的控件模型

 @param childModel 节点模型
 @return 控件模型
 */
- (PsdControlModel *)controlModelWithChildModel:(PsdChildModel *)childModel;
@end
