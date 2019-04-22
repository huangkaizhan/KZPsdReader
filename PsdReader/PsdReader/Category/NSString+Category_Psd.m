//
//  NSString+Category_Psd.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/18.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "NSString+Category_Psd.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Category_Psd)
- (NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)handleSpaceWithString:(NSString *)string
{
    NSString *newString = string;
    NSRange range = [string rangeOfString:@" "];
    if (range.location != NSNotFound) {
        // 去空格
        newString = [string stringByReplacingCharactersInRange:range withString:@""];
        NSString *firstString = [[newString substringWithRange:range] uppercaseString];
        // 变大写
        newString = [newString stringByReplacingCharactersInRange:range withString:firstString];
        newString = [self handleSpaceWithString:newString];
    }
    return newString;
}
@end
