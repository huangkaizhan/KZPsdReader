//
//  PsdRootModel.h
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/20.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PsdChildModel.h"

/**
 根节点模型
 */
@interface PsdRootModel : NSObject

/** 子节点*/
@property (nonatomic, strong) NSArray <PsdChildModel *>*children;

/** 文档节点 ： 暂时不用*/
@property (nonatomic, strong) id document;
@end
