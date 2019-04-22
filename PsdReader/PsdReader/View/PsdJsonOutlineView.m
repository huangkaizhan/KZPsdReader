//
//  PsdJsonOutlineView.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/25.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdJsonOutlineView.h"
#import "PsdDataTool.h"

@interface PsdJsonOutlineView()
/** 封装控件模型*/
@property (nonatomic, strong) NSMutableArray <PsdControlModel *>*packControlArray;
@end

@implementation PsdJsonOutlineView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

ArrayM_Create_Two_Psd(packControlArray, _packControlArray)

- (void)rightMouseDown:(NSEvent *)event
{
    [super rightMouseDown:event];
    [_packControlArray removeAllObjects];
    // 单选直接return
    if (self.selectedRowIndexes.count <= 1) {
        return;
    }
//    NSPoint globalLocation = [event locationInWindow];
//    NSPoint localLocation = [self convertPoint:globalLocation fromView:nil];
//    NSInteger clickedRow = [self rowAtPoint:localLocation];
//    if (clickedRow != -1) {
    
//    }
    // 遍历选中的行
    WeakSelf_Psd
    __block BOOL isOk = YES;
    [self.selectedRowIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        PsdChildModel *selectedModel = [weakSelf itemAtRow:idx];
        if (selectedModel.isLayer) {
            *stop = YES;
            isOk = NO;
            NSLog(@"选中的%@是子控件，不能抽取封装", selectedModel.name);
        } else {
            PsdControlModel *controlModel = [[PsdDataTool sharedTool] controlModelWithChildModel:selectedModel];
            NSLog(@"model.name = %@", selectedModel.name);
            if (controlModel) {
                [weakSelf.packControlArray addObject:controlModel];
            } else {
                *stop = YES;
                isOk = NO;
                NSLog(@"选中的%@控件，因为它没有包含子控件", selectedModel.name);
            }
        }
    }];
    if (!isOk) {
        return;
    }
    
    // 遍历选中模型
    PsdControlType controlType = self.packControlArray.firstObject.controlType;
    for (NSInteger i = 1; i < self.packControlArray.count; i++) {
        PsdControlModel *model = self.packControlArray[i];
        if (model.controlType != controlType) {
            isOk = NO;
            break;
        }
    }
    if (!isOk) {
        NSLog(@"选中的控件类型不一致");
        return;
    }
    
    // 显示菜单吧
    NSMenu *theMenu = [[NSMenu alloc] initWithTitle:@"OptionMenu"];
    [theMenu insertItemWithTitle:@"封装为统一类型" action:@selector(packaging:) keyEquivalent:@"" atIndex:0];
//    [theMenu insertItemWithTitle:@"Honk" action:@selector(honk:) keyEquivalent:@"" atIndex:1];
    
    [NSMenu popUpContextMenu:theMenu withEvent:event forView:self];
}

- (void)packaging:(NSMenuItem *)menuItem
{
    if (self.packBlock) {
        self.packBlock(self.packControlArray);
    }
}

@end
