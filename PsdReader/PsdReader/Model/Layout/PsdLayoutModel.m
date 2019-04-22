//
//  PsdLayoutModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/31.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdLayoutModel.h"
#import "PsdControlModel.h"

static NSInteger LabelMargin = 2;
static NSInteger ButtonWidthMargin = 2;
static NSInteger ButtonTopBottomMargin = 7;

@implementation PsdLayoutModel

@end


@implementation PsdLayoutModel (iOS)

- (void)setLeft:(CGFloat)left
{
    _left = left < 0 ? 0.0 : left;
}

- (void)setTop:(CGFloat)top
{
    _top = top < 0 ? 0.0 : top;
}

- (void)setRight:(CGFloat)right
{
    _right = right < 0 ? 0.0 : right;
}

- (void)setBottom:(CGFloat)bottom
{
    _bottom = bottom < 0 ? 0.0 : bottom;
}

- (CGFloat)centerX
{
    return self.maxX - self.width * 0.5;
}

- (CGFloat)centerY
{
    return self.maxY - self.height * 0.5;
}

- (CGFloat)maxX
{
    return self.left + self.width;
}

- (CGFloat)maxY
{
    return self.top + self.height;
}

- (BOOL)isEqualEdge
{
    return self.isEqualSuperHeight && self.isEqualSuperWidth;
}

- (CGFloat)relativeRight
{
    CGFloat number = 0;
    if (self.relativeRightModel) {
        number = self.maxX - self.relativeRightModel.layoutModel.left;
    }
    return number;
}

- (CGFloat)relativeLeft
{
    CGFloat number = 0;
    if (self.relativeLeftModel) {
        number = self.left - self.relativeLeftModel.layoutModel.maxX;
    }
    return number;
}

- (CGFloat)relativeTop
{
    CGFloat number = 0;
    if (self.relativeTopModel) {
        number = self.top - self.relativeTopModel.layoutModel.maxY;
    }
    return number;
}

#pragma mark - iOS
- (CGFloat)iOS_top
{
    CGFloat iosTop = self.top * 0.5;
//    if (self.controlType == PsdControlTypeButton) {
//        iosTop -= ButtonTopBottomMargin;
//    }
    return iosTop;
}

//- (CGFloat)iOS_alignTop
//{
//    return self.controlType == PsdControlTypeButton ? -ButtonTopBottomMargin : 0;
//}

-(CGFloat)iOS_left
{
    CGFloat iosLeft = self.left * 0.5;
    return iosLeft;
}

-(CGFloat)iOS_right
{
    return self.right * 0.5;
}

-(CGFloat)iOS_bottom
{
    CGFloat number = self.bottom * 0.5;
//    if (self.controlType == PsdControlTypeButton) {
//        number -= ButtonTopBottomMargin;
//    }
    return number;
}

//- (CGFloat)iOS_alignBottom
//{
//    return self.controlType == PsdControlTypeButton ? ButtonTopBottomMargin : 0;
//}

-(CGFloat)iOS_width
{
    CGFloat width = self.width * 0.5;
    // 文字要多左右为2的间距
    if (self.controlType == PsdControlTypeButton) {
        width += ButtonWidthMargin;
    }
    return width;
}

-(CGFloat)iOS_height
{
    CGFloat iosH = self.height * 0.5;
    // 文字要多左右为2的间距
    if (self.controlType == PsdControlTypeButton) {
        iosH += ButtonWidthMargin;
    }
    return iosH;
}

- (CGFloat)iOS_relativeTop
{
    CGFloat number = self.relativeTop * 0.5;
//    if (self.controlType == PsdControlTypeButton) {
//        number -= ButtonTopBottomMargin;
//    }
    return number;
}

- (CGFloat)iOS_relativeLeft
{
    return self.relativeLeft * 0.5;
}

- (CGFloat)iOS_relativeRight
{
    return self.relativeRight * 0.5;
}

@end
