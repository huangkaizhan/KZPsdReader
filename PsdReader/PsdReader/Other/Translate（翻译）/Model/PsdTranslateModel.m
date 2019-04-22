//
//  PsdTranslateModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/18.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdTranslateModel.h"
#import "MJExtension.h"
#import "NSString+Category_Psd.h"

@implementation PsdTranslateModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"result" : @"dst",
              @"query" : @"src",
              };
}

- (void)setResult:(NSString *)result
{
    // 处理空格，
    result = [result handleSpaceWithString:result];
    // 处理'符号
    result = [result stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _result = result;
}




@end
