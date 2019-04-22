//
//  PsdStandarLabelModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/30.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdStandarLabelModel.h"

@implementation PsdStandarLabelModel

- (NSString *)findIdentify
{
    return Control_Label_Name_Find;
}

- (NSString *)nameUpper
{
    return Control_Label_Name_Upper;
}

- (NSString *)nameLower
{
    return Control_Label_Name_Lower;
}

- (NSString *)className
{
    return Control_Label_Name_Control;
}

- (NSString *)controlNameChinese
{
    return Control_Label_Name_Chinese;
}

- (PsdControlType)type
{
    return PsdControlTypeLabel;
}


@end
