//
//  PsdImageViewMaker.m
//  PsdReader
//
//  Created by huang kaizhan on 2017/12/31.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdImageViewMaker.h"

@implementation PsdImageViewMaker

- (NSMutableString *)create
{
    NSMutableString *controlString = [NSMutableString string];
    [controlString appendString:[self createPrepareUIMethodDefineString]];
    NSString *labelValName = self.controlVarName;
    [controlString appendFormat:@"%@%@%@", KeySpace, FormatterLayoutFactorDefine, KeyLineFeed];
    [controlString appendFormat:@"%@%@ *%@ = [[%@ alloc] init];%@", KeySpace, Control_ImageView_Name_Control, labelValName, Control_ImageView_Name_Control, KeyLineFeed];
    [controlString appendFormat:@"%@%@.contentMode = UIViewContentModeScaleAspectFill;%@", KeySpace, labelValName, KeyLineFeed];
    [controlString appendFormat:@"#warning 这里只是方便显示图片，没用请去掉%@", KeyLineFeed];
    [controlString appendFormat:@"%@%@.backgroundColor = [UIColor orangeColor];%@", KeySpace, labelValName, KeyLineFeed];
    [controlString appendString:[super create]];
    [controlString appendString:@"}\r\n"];
    return controlString;
}

@end
