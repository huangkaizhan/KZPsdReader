//
//  PsdControlInfoView.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/22.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PsdControlModel;

@interface PsdControlInfoView : NSView

/** 模型*/
@property (nonatomic, strong) PsdControlModel *model;

/** 节点模型*/
@property (nonatomic, strong) PsdChildModel *childModel;

/** 修改变量名代码块*/
@property (nonatomic, copy) BlockWithObject_Psd changeValNameBlock;
@end
