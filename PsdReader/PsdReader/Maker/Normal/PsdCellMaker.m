//
//  PsdCellMaker.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/2/3.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdCellMaker.h"

@implementation PsdCellMaker

- (NSString *)addSubViewString
{
    return [NSString stringWithFormat:@"%@[self.contentView addSubview:%@];%@", KeySpace, self.controlVarName, KeyLineFeed];
}

@end
