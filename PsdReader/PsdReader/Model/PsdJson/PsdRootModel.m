//
//  PsdRootModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/20.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdRootModel.h"
#import "MJExtension.h"

@implementation PsdRootModel

+ (NSDictionary *)objectClassInArray
{
    return @{ @"children" : [PsdChildModel class] };
}

@end
