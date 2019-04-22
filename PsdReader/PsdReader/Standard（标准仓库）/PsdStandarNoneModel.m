//
//  PsdStandarNoneModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/30.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdStandarNoneModel.h"

@implementation PsdStandarNoneModel

- (NSString *)findIdentify
{
    return @"";
}

- (NSString *)nameUpper
{
    return @"";
}

- (NSString *)nameLower
{
    return @"";
}

- (NSString *)className
{
    return @"";
}

- (NSString *)controlNameChinese
{
    return @"不是控件";
}

- (PsdControlType)type
{
    return PsdControlTypeNone;
}

@end
