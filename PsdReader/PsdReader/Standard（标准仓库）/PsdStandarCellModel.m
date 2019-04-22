//
//  PsdStandarCellModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/30.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdStandarCellModel.h"

@implementation PsdStandarCellModel

- (NSString *)findIdentify
{
    return Control_Cell_Name_Find;
}

- (NSString *)nameUpper
{
    return Control_Cell_Name_Upper;
}

- (NSString *)nameLower
{
    return Control_Cell_Name_Lower;
}

- (NSString *)className
{
    return Control_Cell_Name_Control;
}

- (NSString *)controlNameChinese
{
    return Control_Cell_Name_Chinese;
}

- (PsdControlType)type
{
    return PsdControlTypeCell;
}
@end
