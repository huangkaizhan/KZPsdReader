//
//  PsdNetTool.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/18.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PsdTranslateModel.h"

@interface PsdNetTool : NSObject

+ (void)translateWithText:(NSString *)text completionBlock:(BlockWithObject_Psd)completionBlock;
@end
