//
//  PsdStandarButtonModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/30.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdStandarButtonModel.h"

@implementation PsdStandarButtonModel

- (NSString *)findIdentify
{
    return Control_Button_Name_Find;
}

- (NSString *)nameUpper
{
    return Control_Button_Name_Upper;
}

- (NSString *)nameLower
{
    return Control_Button_Name_Lower;
}

- (NSString *)className
{
    return Control_Button_Name_Control;
}

- (NSString *)controlNameChinese
{
    return Control_Button_Name_Chinese;
}
- (PsdControlType)type
{
    return PsdControlTypeButton;
}

@end
