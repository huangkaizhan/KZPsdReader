//
//  PsdViewMaker.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/19.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdViewMaker.h"
#import "PsdCustomControlModel.h"

@implementation PsdViewMaker

- (NSMutableString *)create
{
    NSMutableString *controlString = [NSMutableString string];
    [controlString appendString:[self createPrepareUIMethodDefineString]];
    NSString *className = Control_View_Name_Control;
    if ([self.controlModel isKindOfClass:[PsdCustomControlModel class]]) {
        className = ((PsdCustomControlModel *)self.controlModel).fileName;
    }
    [controlString appendFormat:@"%@%@%@", KeySpace, FormatterLayoutFactorDefine, KeyLineFeed];
    [controlString appendFormat:@"%@%@ *%@ = [[%@ alloc] init];%@", KeySpace, className, self.controlVarName, className, KeyLineFeed];
    if (self.controlModel.opacity != 1.0) {
        [controlString appendFormat:@"%@.backgroundColor = [UIColor blackColor];%@", self.controlVarName, KeyLineFeed];
        [controlString appendFormat:@"%@%@.alpha = %.1f;%@", KeySpace, self.controlVarName, self.controlModel.opacity, KeyLineFeed];
    } else{
        [controlString appendFormat:@"%@.backgroundColor = [UIColor grayColor];%@", self.controlVarName, KeyLineFeed];
    }
    [controlString appendString:[super create]];
    [controlString appendString:@"}\r\n"];
    return controlString;
}

@end
