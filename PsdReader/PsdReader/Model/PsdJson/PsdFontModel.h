//
//  PsdFontModel.h
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/19.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PsdFontModel : NSObject


/** 字体名称*/
@property (nonatomic, copy) PSDJSON NSString *name;

/** 字体大小数组，取第一个*/
@property (nonatomic, strong) PSDJSON NSArray *sizes;

/** 颜色数组，取第一个*/
@property (nonatomic, strong) PSDJSON NSArray *colors;

/** 对齐方式，取第一个*/
@property (nonatomic, strong) PSDJSON NSArray *alignment;

#pragma mark - 辅助属性
/** 字体大小*/
@property (nonatomic, assign) NSInteger fontSize;

/** 颜色*/
@property (nonatomic, strong) NSColor *fontColor;

/** 颜色R*/
@property (nonatomic, copy) NSString *colorR;

/** 颜色G*/
@property (nonatomic, copy) NSString *colorG;

/** 颜色B*/
@property (nonatomic, copy) NSString *colorB;

/** 颜色A*/
@property (nonatomic, copy) NSString *colorA;

/** 对齐方式*/
@property (nonatomic, copy) NSString *fontAlignment;

#pragma mark - iOS辅助属性
/** 字体大小*/
@property (nonatomic, assign) NSInteger iOS_fontSize;
@end
