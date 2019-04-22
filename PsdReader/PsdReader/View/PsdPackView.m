//
//  PsdPackView.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/25.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdPackView.h"
#import "PsdCustomControlModel.h"

@interface PsdPackView()
@property (weak) IBOutlet NSView *backView;
@property (weak) IBOutlet NSTextField *titleTextField;
@property (weak) IBOutlet NSView *contentView;

@end

@implementation PsdPackView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backView.wantsLayer = YES;
    self.backView.layer.backgroundColor = [NSColor colorWithRed:0 / 255.f green:0 / 255.f blue:0 / 255.f alpha:0.3].CGColor;
    self.contentView.wantsLayer = YES;
    self.contentView.layer.backgroundColor = [NSColor whiteColor].CGColor;
}

- (IBAction)submitButtonClicked:(id)sender {
    if (self.titleTextField.stringValue.length && self.submitBlock) {
        self.hidden = YES;
        for (PsdCustomControlModel *model in self.controlModelArray) {
            if ([model isKindOfClass:[PsdCustomControlModel class]]) {
                [model updateClassName:self.titleTextField.stringValue];
            }
        }
        self.submitBlock(self.controlModelArray);
    }
}

@end
