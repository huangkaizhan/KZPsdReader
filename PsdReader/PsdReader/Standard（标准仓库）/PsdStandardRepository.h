//
//  PsdStandarTool.h
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/29.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton_lib.h"
#import "PsdStandarControlModel.h"

/**
 标准工具，存储一些规范化的格式
 */
@interface PsdStandardRepository : NSObject

SingletonH_lib(Repository)

/** 控件集合*/
@property (nonatomic, strong) NSArray <PsdStandarControlModel *>*controlModelArray;

// 数字数组
@property (nonatomic, strong) NSMutableArray *reuseNumberArray;

//// 控件相关字典
//@property (nonatomic, strong) NSDictionary *controlDict;

/** 点击事件key*/
@property (nonatomic, copy) NSString *clickKey;

/** 无效变量名数组*/
@property (nonatomic, strong) NSArray *invalidValNameArray;

/** 系统存在的变量名字典*/
@property (nonatomic, strong) NSDictionary *systemValNameDict;

/** 文字变量名数组*/
@property (nonatomic, strong) NSArray <NSString *>*labelNameArray;
@end
