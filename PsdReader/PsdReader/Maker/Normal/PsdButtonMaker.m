//
//  PsdButtonMaker.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/24.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdButtonMaker.h"

@implementation PsdButtonMaker

- (NSMutableString *)create
{
    NSMutableString *controlString = [NSMutableString string];
    [controlString appendString:[self createPrepareUIMethodDefineString]];
    NSInteger fontSize = self.controlModel.text.font.iOS_fontSize;
    [controlString appendFormat:@"%@%@%@", KeySpace, FormatterLayoutFactorDefine, KeyLineFeed];
    [controlString appendFormat:@"%@%@ *%@ = [%@ buttonWithType:UIButtonTypeCustom];%@", KeySpace, Control_Button_Name_Control, self.controlVarName, Control_Button_Name_Control, KeyLineFeed];
    // 标题
    [controlString appendFormat:@"%@[%@ setTitle:@\"%@\" forState:UIControlStateNormal];%@", KeySpace, self.controlVarName, self.controlModel.text.value, KeyLineFeed];
    // 字体
    [controlString appendFormat:@"%@%@.titleLabel.font = [UIFont systemFontOfSize:%zd%@];%@", KeySpace, self.controlVarName, fontSize, FormatterLayoutFactor, KeyLineFeed];
    // 字体颜色
     NSString *colorString = [NSString stringWithFormat:@"[UIColor colorWithRed:%@ / 255.0f green:%@ / 255.0f blue:%@ / 255.0f alpha:%@]", self.controlModel.text.font.colorR, self.controlModel.text.font.colorG, self.controlModel.text.font.colorB, self.controlModel.text.font.colorA];
    [controlString appendFormat:@"%@[%@ setTitleColor:%@ forState:UIControlStateNormal];%@", KeySpace, self.controlVarName, colorString, KeyLineFeed];
    // 高亮不调整
    [controlString appendFormat:@"%@[%@ setAdjustsImageWhenHighlighted:NO];%@", KeySpace, self.controlVarName, KeyLineFeed];
    // 点击事件
    [controlString appendString:[self createTapGestureEventString]];
    // 布局
    [controlString appendString:[super createLayoutString]];
    [controlString appendString:@"}\r\n"];
    return controlString;
}

//- (NSMutableString *)createWidthLayoutString
//{
//    NSMutableString *widthLayoutString = [NSMutableString string];
//    // 1. 这个控件有可能是单行控件
//    // 2. 这个控件有可能是单行最后一个右边布局的控件
//    if (self.controlModel.layoutModel.isSingleLineControl) {
//        CGFloat right = -(self.controlModel.layoutModel.left * 0.5);
//        [widthLayoutString appendFormat:@"%@%@make.right.mas_lessThanOrEqualTo(%.1f);%@", KeySpace, KeySpace, right, KeyLineFeed];
//    }
//    return widthLayoutString;
//}

//// 按钮不需要高度布局
//- (NSMutableString *)createHeightLayoutString
//{
//    return [NSMutableString string];
//}

- (NSMutableString *)createWidthLayoutString
{
    NSMutableString *widthLayoutString = [NSMutableString string];
//    // 1. 这个控件有可能是单行控件
//    // 2. 这个控件有可能是单行最后一个右边布局的控件
//    BOOL useWidth = self.usedRightLayout;
//    if (!useWidth) {
//        if (self.controlModel.layoutModel.alignRightModel) {
//            useWidth = YES;
//        } else if (self.controlModel.layoutModel.isSingleLineControl) {
//            useWidth = NO;
//        } else if ((self.controlModel.layoutModel.userRightLayout && !self.controlModel.layoutModel.relativeRightModel)) {
//            useWidth = NO;
//        }
//    }
//    if (useWidth) {
        [widthLayoutString appendFormat:@"%@%@make.width.mas_equalTo(%.1f);%@", KeySpace, KeySpace, self.controlModel.layoutModel.iOS_width, KeyLineFeed];
//    } else {
//        CGFloat right = (self.controlModel.superModel.layoutModel.right - self.controlModel.layoutModel.right) * 0.5;
//        [widthLayoutString appendFormat:@"%@%@make.right.mas_equalTo(%.1f);%@", KeySpace, KeySpace, right, KeyLineFeed];
//    }
    return widthLayoutString;
}

// 添加点击手势字符串
- (NSMutableString *)createTapGestureEventString
{
    NSMutableString *eventString = [NSMutableString string];
    // 点击事件
    [eventString appendFormat:@"%@[%@ addTarget:self action:@selector(%@Clicked:) forControlEvents:UIControlEventTouchUpInside];%@", KeySpace, self.controlVarName, self.controlVarName, KeyLineFeed];
    return eventString;
}

- (NSMutableString *)createTapMethodEventString
{
    NSMutableString *eventString = [NSMutableString string];
    [eventString appendFormat:@"%@// <#zhushi#>%@",KeyLineFeed, KeyLineFeed];
    [eventString appendFormat:@"- (void)%@Clicked:(UIButton *)button%@{%@%@}%@",self.controlVarName, KeyLineFeed, KeyLineFeed, KeyLineFeed, KeyLineFeed];
    return eventString;
}

@end
