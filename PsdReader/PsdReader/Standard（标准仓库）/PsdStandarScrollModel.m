//
//  PsdStandarScrollModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/30.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdStandarScrollModel.h"

@implementation PsdStandarScrollModel

- (NSString *)findIdentify
{
    return Control_ScrollView_Name_Find;
}

- (NSString *)nameUpper
{
    return Control_ScrollView_Name_Upper;
}

- (NSString *)nameLower
{
    return Control_ScrollView_Name_Lower;
}

- (NSString *)className
{
    return Control_ScrollView_Name_Control;
}

- (NSString *)controlNameChinese
{
    return Control_ScrollView_Name_Chinese;
}

- (PsdControlType)type
{
    return PsdControlTypeScrollView;
}
@end
