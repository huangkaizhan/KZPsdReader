//
//  PsdImageContentView.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/15.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PsdChildModel;

@interface PsdImageContentView : NSView

// 选中模型
@property (nonatomic, strong) PsdChildModel *model;

// 图片
@property (nonatomic, strong) NSImage *image;
@end
