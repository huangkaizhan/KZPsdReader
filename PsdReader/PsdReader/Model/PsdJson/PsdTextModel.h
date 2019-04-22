//
//  PsdTextModel.h
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/19.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PsdFontModel.h"

@interface PsdTextModel : NSObject

/** 内容*/
@property (nonatomic, copy) PSDJSON NSString *value;

/** 字体模型*/
@property (nonatomic, strong) PSDJSON PsdFontModel *font;

@end
