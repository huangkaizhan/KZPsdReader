//
//  PsdStandarControlModel.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/30.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PsdControlConfig.h"

@interface PsdStandarControlModel : NSObject

/** 查找容器标识符，从photoshop读取识别*/
@property (nonatomic, copy) NSString *findIdentify;
/** 大写*/
@property (nonatomic, copy) NSString *nameUpper;
/** 小写*/
@property (nonatomic, copy) NSString *nameLower;
/** 控件名*/
@property (nonatomic, copy) NSString *className;
/** 控件名汉语*/
@property (nonatomic, copy) NSString *controlNameChinese;
/** 控件类型*/
@property (nonatomic, assign) PsdControlType type;

@end
