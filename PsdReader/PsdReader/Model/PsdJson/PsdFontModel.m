//
//  PsdFontModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/19.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdFontModel.h"
#import "MJExtension.h"

@implementation PsdFontModel

MJCodingImplementation

- (void)setSizes:(NSArray *)sizes
{
    _sizes = sizes;
    if (sizes.count) {
        _fontSize = [sizes.firstObject integerValue];
        _iOS_fontSize = _fontSize * 0.5;
    }
}

- (void)setAlignment:(NSArray *)alignment
{
    _alignment = alignment;
    if (alignment.count) {
        NSString *text = alignment.firstObject;
        if ([text isEqualToString:@"left"]) {
            _fontAlignment = @"NSTextAlignmentLeft";
        } else if ([text isEqualToString:@"right"]) {
            _fontAlignment =  @"NSTextAlignmentRight";
        } else if ([text isEqualToString:@"center"]) {
            _fontAlignment =  @"NSTextAlignmentCenter";
        } else {
            _fontAlignment = @"";
            NSLog(@"不知道什么对齐方式 %@", text);
        }
    }
}

ObjectCreateValue_Psd(NSString, colorA, _colorA, @"");
ObjectCreateValue_Psd(NSString, colorB, _colorB, @"");
ObjectCreateValue_Psd(NSString, colorG, _colorG, @"");
ObjectCreateValue_Psd(NSString, colorR, _colorR, @"");

- (void)setColors:(NSArray *)colors
{
    _colors = colors;
    if (colors.count) {
        NSArray *colorStringArray = colors.firstObject;
        if (colorStringArray.count >= 3) {
            CGFloat red = [colorStringArray.firstObject floatValue] / 255.0f;
            CGFloat green = [colorStringArray[1] floatValue] / 255.0f;
            CGFloat blue = [colorStringArray[2] floatValue] / 255.0f;
            CGFloat alpha = 1.0f;
            if (colorStringArray.count == 4) {
#warning 不知道对不对
                alpha = [colorStringArray[3] floatValue] / 255.0f;
            }
            _colorR = colorStringArray.firstObject;
            _colorG = colorStringArray[1];
            _colorB = colorStringArray[2];
            _colorA = [NSString stringWithFormat:@"%.1f", alpha];
            _fontColor = [NSColor colorWithRed:red green:green blue:blue alpha:alpha];
        }
    }
}

@end
