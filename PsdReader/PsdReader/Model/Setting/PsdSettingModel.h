//
//  PsdSettingModel.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/2/5.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton_lib.h"

@interface PsdSettingModel : NSObject

SingletonH_lib(Model);

/** 是否启用缩放比例布局*/
@property (nonatomic, assign) BOOL isEnableLayoutFactor;

/** 作者名*/
@property (nonatomic, copy) NSString *authorName;

/** 控件前缀*/
@property (nonatomic, copy) NSString *prefix;

@end
