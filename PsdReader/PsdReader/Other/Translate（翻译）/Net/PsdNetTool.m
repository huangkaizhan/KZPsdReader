//
//  PsdNetTool.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/18.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdNetTool.h"
#import "AFNetworking.h"
#import "NSString+Category_Psd.h"

@interface PsdNetTool()

@end

@implementation PsdNetTool

/** 百度翻译appid*/
static NSString *Key_Baidu_Translate_AppId = @"20180118000116441";
/** 百度翻译秘钥*/
static NSString *Key_Baidu_Translate_Securekey = @"Q4P4Ro1h3EQtP1BDxW_a";
/** 百度翻译apid*/
static NSString *Key_Baidu_Translate_Api = @"https://fanyi-api.baidu.com/api/trans/vip/translate";

+ (void)translateWithText:(NSString *)text completionBlock:(BlockWithObject_Psd)completionBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:text forKey:@"q"];
    [dict setObject:@"zh" forKey:@"from"];
    [dict setObject:@"en" forKey:@"to"];
    [dict setObject:Key_Baidu_Translate_AppId forKey:@"appid"];
    NSString *salt = [NSString stringWithFormat:@"%zd",(NSInteger)([[NSDate date] timeIntervalSince1970])];
    [dict setObject:salt forKey:@"salt"];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@",Key_Baidu_Translate_AppId, text, salt, Key_Baidu_Translate_Securekey];
    sign = [sign md5];
    [dict setObject:sign forKey:@"sign"];
    [[AFHTTPSessionManager manager] GET:Key_Baidu_Translate_Api parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *transResultArray = responseObject[@"trans_result"];
        if (transResultArray.firstObject) {
            PsdTranslateModel *model = [PsdTranslateModel objectWithKeyValues:transResultArray.firstObject];
            if (completionBlock) {
                completionBlock(model);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"translate error = %@", error.description);
    }];
}


@end
