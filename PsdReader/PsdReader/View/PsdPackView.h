//
//  PsdPackView.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/25.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PsdControlModel;

@interface PsdPackView : NSView

/** 确定*/
@property (nonatomic, copy) BlockWithObject_Psd submitBlock;

/** 控件数组*/
@property (nonatomic, strong) NSMutableArray <PsdControlModel *>* controlModelArray;
@end
