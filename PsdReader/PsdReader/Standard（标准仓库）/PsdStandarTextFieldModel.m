//
//  PsdStandarTextFieldModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/30.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdStandarTextFieldModel.h"

@implementation PsdStandarTextFieldModel
- (NSString *)findIdentify
{
    return Control_TextField_Name_Find;
}

- (NSString *)nameUpper
{
    return Control_TextField_Name_Upper;
}

- (NSString *)nameLower
{
    return Control_TextField_Name_Lower;
}

- (NSString *)className
{
    return Control_TextField_Name_Control;
}

- (NSString *)controlNameChinese
{
    return Control_TextField_Name_Chinese;
}

- (PsdControlType)type
{
    return PsdControlTypeTextField;
}
@end
