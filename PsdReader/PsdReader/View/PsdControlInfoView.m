//
//  PsdControlInfoView.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/22.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdControlInfoView.h"
#import "PsdControlModel.h"
#import "PsdStandardRepository.h"

@interface PsdControlInfoView()
@property (weak) IBOutlet NSTextField *layerTextField;
@property (weak) IBOutlet NSTextField *xTextField;
@property (weak) IBOutlet NSTextField *yTextField;
@property (weak) IBOutlet NSTextField *widthTextField;
@property (weak) IBOutlet NSTextField *heightTextField;
@property (weak) IBOutlet NSTextField *alphaTextField;
@property (weak) IBOutlet NSTextField *colorTextField;
@property (weak) IBOutlet NSTextField *fontTextField;
@property (weak) IBOutlet NSTextField *alignmentTextField;
@property (weak) IBOutlet NSTextField *fontSizeTextField;
@property (weak) IBOutlet NSTextField *contentTextField;
@property (weak) IBOutlet NSTextField *controlNameTextField;
@property (weak) IBOutlet NSTextField *controlValNameTextField;
@property (weak) IBOutlet NSComboBox *controlTypeComboBox;

@end

@implementation PsdControlInfoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    for (PsdStandarControlModel *controlModel in [PsdStandardRepository sharedRepository].controlModelArray) {
        [self.controlTypeComboBox addItemWithObjectValue:controlModel.controlNameChinese];
    }
    
}

- (void)setModel:(PsdControlModel *)model
{
    _model = model;
    self.controlNameTextField.stringValue = model.controlClassName ? model.controlClassName : @"";
    self.controlValNameTextField.stringValue = model.controlVarName ? model.controlVarName : @"";
    [self.controlTypeComboBox selectItemAtIndex:model.controlType];
}

- (void)setChildModel:(PsdChildModel *)childModel
{
    _childModel = childModel;
    self.layerTextField.stringValue = childModel.name;
    self.xTextField.stringValue = FloatString_Psd(childModel.left);
    self.yTextField.stringValue = FloatString_Psd(childModel.top);
    self.widthTextField.stringValue = FloatString_Psd(childModel.width);
    self.heightTextField.stringValue = FloatString_Psd(childModel.height);
    self.alphaTextField.stringValue = FloatString_Psd(childModel.opacity);
    self.colorTextField.stringValue = childModel.text.font.colorA ? childModel.text.font.colorA : @"";
    self.fontTextField.stringValue = childModel.text.font.name ? childModel.text.font.name : @"";
    self.alignmentTextField.stringValue = childModel.text.font.fontAlignment ? childModel.text.font.fontAlignment : @"";
    self.fontSizeTextField.stringValue = IntString_Psd(childModel.text.font.fontSize);
    self.contentTextField.stringValue = childModel.text.value ? childModel.text.value : @"";
}

- (IBAction)submit:(NSButton *)sender
{
    if (![self.model.controlVarName isEqualToString:self.controlValNameTextField.stringValue]) {
        [self.model updateValName:self.controlValNameTextField.stringValue];
        if (self.changeValNameBlock) {
            self.changeValNameBlock(self.childModel);
        }
    }
}
- (IBAction)comboBoxChanged:(NSComboBox *)box
{
    PsdControlType type = (PsdControlType)[box indexOfSelectedItem];
    
    
}
@end
