//
//  PsdStandarImageViewModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/30.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdStandarImageViewModel.h"

@implementation PsdStandarImageViewModel

- (NSString *)findIdentify
{
    return Control_ImageView_Name_Find;
}

- (NSString *)nameUpper
{
    return Control_ImageView_Name_Upper;
}

- (NSString *)nameLower
{
    return Control_ImageView_Name_Lower;
}

- (NSString *)className
{
    return Control_ImageView_Name_Control;
}

- (NSString *)controlNameChinese
{
    return Control_ImageView_Name_Chinese;
}

- (PsdControlType)type
{
    return PsdControlTypeImageView;
}
@end
