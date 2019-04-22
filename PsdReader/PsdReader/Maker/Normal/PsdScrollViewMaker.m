//
//  PsdScrollViewMaker.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/25.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdScrollViewMaker.h"
#import "PsdCustomControlModel.h"

@implementation PsdScrollViewMaker

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
        [controlString appendFormat:@"%@%@.alpha = %.1f", KeySpace, self.controlVarName, 1.0 - self.controlModel.opacity];
    }
    [controlString appendString:[super create]];
    [controlString appendString:@"}\r\n"];
    return controlString;
}

@end
