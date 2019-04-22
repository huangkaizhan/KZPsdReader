//
//  PsdTranslateModel.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/18.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 翻译模型
 */
@interface PsdTranslateModel : NSObject

/** 翻译结果*/
@property (nonatomic, copy) NSString *result;

/** 翻译内容*/
@property (nonatomic, copy) NSString *query;

@end
