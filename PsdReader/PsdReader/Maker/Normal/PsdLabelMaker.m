//
//  PsdLabelMaker.m
//  PsdReader
//
//  Created by huang kaizhan on 2017/12/31.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdLabelMaker.h"
#import "PsdCustomControlModel.h"

@implementation PsdLabelMaker

- (NSMutableString *)create
{
    NSMutableString *controlString = [NSMutableString string];
    [controlString appendString:[self createPrepareUIMethodDefineString]];
    NSString *labelValName = self.controlVarName;
    NSInteger fontSize = self.controlModel.text.font.iOS_fontSize;
    [controlString appendFormat:@"%@%@%@", KeySpace, FormatterLayoutFactorDefine, KeyLineFeed];
    [controlString appendFormat:@"%@%@ *%@ = [[%@ alloc] init];%@", KeySpace, Control_Label_Name_Control, labelValName, Control_Label_Name_Control, KeyLineFeed];
    [controlString appendFormat:@"%@%@.font = [UIFont systemFontOfSize:%zd%@];%@", KeySpace, labelValName, fontSize, FormatterLayoutFactor, KeyLineFeed];
    [controlString appendFormat:@"%@%@.textColor =  [UIColor colorWithRed:%@ / 255.0f green:%@ / 255.0f blue:%@ / 255.0f alpha:%@];%@", KeySpace, labelValName, self.controlModel.text.font.colorR, self.controlModel.text.font.colorG, self.controlModel.text.font.colorB, self.controlModel.text.font.colorA, KeyLineFeed];
    [controlString appendFormat:@"%@%@.textAlignment = %@;%@", KeySpace, labelValName, self.controlModel.text.font.fontAlignment, KeyLineFeed];
    // 行数
    NSInteger line = 1;
    NSMutableString *lineString = [NSMutableString stringWithString:self.controlModel.text.value];
    NSRange range = [self.controlModel.text.value rangeOfString:@"\r"];;
    while (range.location != NSNotFound) {
        [lineString deleteCharactersInRange:range];
        range = [lineString rangeOfString:@"\r"];
        line++;
    }
    if (line > 1) {
        // 三行基本都是内容了，内容基本是0
        if (line > 2) {
            [controlString appendFormat:@"%@%@.numberOfLines = 0;%@", KeySpace, labelValName, KeyLineFeed];
        } else {
            // 两行要设置
            [controlString appendFormat:@"%@%@.numberOfLines = %zd;%@", KeySpace, labelValName, line, KeyLineFeed];
        }
    }
    [controlString appendFormat:@"%@%@.text = @\"%@\";%@", KeySpace, labelValName, lineString, KeyLineFeed];
    [controlString appendString:[super create]];
    [controlString appendString:@"}\r\n"];
    return controlString;
}

- (NSMutableString *)createWidthLayoutString
{
    NSMutableString *widthLayoutString = [NSMutableString string];
    // 1. 这个控件有可能是单行控件
    // 2. 这个控件有可能是单行最后一个右边布局的控件
    if (self.controlModel.layoutModel.isSingleLineControl) {
        CGFloat right = -(self.controlModel.layoutModel.left * 0.5);
        [widthLayoutString appendFormat:@"%@%@make.right.mas_lessThanOrEqualTo(%.1f%@);%@", KeySpace, KeySpace, right, FormatterLayoutFactor, KeyLineFeed];
    } else if (self.controlModel.layoutModel.relativeRightModel) {
        [widthLayoutString appendFormat:@"%@%@make.right.lessThanOrEqualTo(weakSelf.%@.mas_left).offset(%.1f%@);%@", KeySpace, KeySpace, self.controlModel.layoutModel.relativeRightModel.controlVarName, self.controlModel.layoutModel.iOS_relativeRight, FormatterLayoutFactor, KeyLineFeed];
    }
    return widthLayoutString;
}

// 文字不需要高度布局
- (NSMutableString *)createHeightLayoutString
{
    return [NSMutableString string];
}
@end
