//
//  PsdStandarViewModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/30.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdStandarViewModel.h"

@implementation PsdStandarViewModel

- (NSString *)findIdentify
{
    return Control_View_Name_Find;
}

- (NSString *)nameUpper
{
    return Control_View_Name_Upper;
}

- (NSString *)nameLower
{
    return Control_View_Name_Lower;
}

- (NSString *)className
{
    return Control_View_Name_Control;
}

- (NSString *)controlNameChinese
{
    return Control_View_Name_Chinese;
}

- (PsdControlType)type
{
    return PsdControlTypeView;
}

@end
