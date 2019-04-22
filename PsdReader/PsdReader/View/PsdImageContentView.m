//
//  PsdImageContentView.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/15.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdImageContentView.h"
#import "Masonry.h"
#import "PsdChildModel.h"
#import "PsdChildModel+iOS.h"

@interface PsdImageContentView()

@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSView *imageMaskView;
@property (weak) IBOutlet NSLayoutConstraint *imageMaskViewLeftLayout;
@property (weak) IBOutlet NSLayoutConstraint *imageMaskViewTopLayout;
@property (weak) IBOutlet NSLayoutConstraint *imageMaskViewWidthLayout;
@property (weak) IBOutlet NSLayoutConstraint *imageMaskViewHeightLayout;

// 选中的根节点
@property (nonatomic, weak) PsdChildModel *lastRootModel;
@end

@implementation PsdImageContentView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [_imageMaskView setWantsLayer:YES];
    [_imageMaskView.layer setBackgroundColor:[[NSColor colorWithRed:0.0 / 255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:0.2] CGColor]];
}

- (void)setModel:(PsdChildModel *)model
{
    _model = model;
    // 判断是否是跟节点
    if (model.isRootModel) {
        [self selectRootModel:model];
        self.imageMaskView.hidden = YES;
    } else {
        // 不是根节点，那么要判断它的根节点和上次选中的一不一样
        if (![model.rootChildModel isEqual:self.lastRootModel]) {
            [self selectRootModel:model.rootChildModel];
        }
        // 显示遮罩块
        CGFloat top = (model.top - model.rootChildModel.top) * 0.5;
        self.imageMaskViewTopLayout.constant = top;
        self.imageMaskViewLeftLayout.constant = model.iOS_left;
        self.imageMaskViewWidthLayout.constant = model.iOS_width;
        self.imageMaskViewHeightLayout.constant = model.iOS_height;
        self.imageMaskView.hidden = NO;
    }
}

// 选中根节点
- (void)selectRootModel:(PsdChildModel *)rootModel
{
    self.lastRootModel = rootModel;
    self.imageMaskView.hidden = YES;
    
}

- (void)setImage:(NSImage *)image
{
    _image = image;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(image.size.height * 0.5);
        make.width.mas_equalTo(image.size.width * 0.5);
    }];
    self.imageView.image = image;
}
@end
