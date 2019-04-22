//
//  PsdJsonOutlineView.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/25.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PsdJsonOutlineView : NSOutlineView

/** 抽取封装回调*/
@property (nonatomic, copy) BlockWithObject_Psd packBlock;
@end
