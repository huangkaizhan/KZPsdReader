//
//  PsdStandarTool.m
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/29.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdStandardRepository.h"
#import "PsdStandarViewModel.h"
#import "PsdStandarLabelModel.h"
#import "PsdStandarButtonModel.h"
#import "PsdStandarImageViewModel.h"
#import "PsdStandarCellModel.h"
#import "PsdStandarScrollModel.h"
#import "PsdStandarTextFieldModel.h"
#import "PsdStandarNoneModel.h"

@interface PsdStandardRepository()
/** 容器*/
@property (nonatomic, strong) PsdStandarViewModel *viewModel;
/** 文字*/
@property (nonatomic, strong) PsdStandarLabelModel *labelModel;
/** 按钮*/
@property (nonatomic, strong) PsdStandarButtonModel *buttonModel;
/** 图片*/
@property (nonatomic, strong) PsdStandarImageViewModel *imageModel;
/** 单元*/
@property (nonatomic, strong) PsdStandarCellModel *cellModel;
/** 滚动*/
@property (nonatomic, strong) PsdStandarScrollModel *scrollModel;
/** 输入框*/
@property (nonatomic, strong) PsdStandarTextFieldModel *textFieldModel;
/** 不是控件*/
@property (nonatomic, strong) PsdStandarNoneModel *notControlModel;
@end

@implementation PsdStandardRepository

SingletonM_lib(Repository)

ObjectCreate_Psd(PsdStandarViewModel, viewModel, _viewModel);
ObjectCreate_Psd(PsdStandarLabelModel, labelModel, _labelModel);
ObjectCreate_Psd(PsdStandarButtonModel, buttonModel, _buttonModel);
ObjectCreate_Psd(PsdStandarImageViewModel, imageModel, _imageModel);
ObjectCreate_Psd(PsdStandarCellModel, cellModel, _cellModel);
ObjectCreate_Psd(PsdStandarScrollModel, scrollModel, _scrollModel);
ObjectCreate_Psd(PsdStandarTextFieldModel, textFieldModel, _textFieldModel);
ObjectCreate_Psd(PsdStandarNoneModel, notControlModel, _notControlModel);

- (NSArray <PsdStandarControlModel *>*)controlModelArray
{
    if (!_controlModelArray) {
        _controlModelArray = @[self.notControlModel, self.viewModel, self.labelModel, self.buttonModel, self.imageModel, self.cellModel, self.scrollModel, self.textFieldModel];
    }
    return _controlModelArray;
}

- (NSMutableArray *)reuseNumberArray
{
    if (!_reuseNumberArray) {
        _reuseNumberArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            [_reuseNumberArray addObject:[NSString stringWithFormat:@"%zd", i]];
        }
    }
    return _reuseNumberArray;
}

- (NSArray *)invalidValNameArray
{
    if (!_invalidValNameArray) {
        _invalidValNameArray = @[@"#", @"%", @".", @"|", @"-", @"/"];
    }
    return _invalidValNameArray;
}

- (NSDictionary *)systemValNameDict
{
    if (!_systemValNameDict) {
        _systemValNameDict = @{@"mask" : @"backMask", @"Mask" : @"backMask"};
    }
    return _systemValNameDict;
}

- (NSArray<NSString *> *)labelNameArray
{
    if (!_labelNameArray) {
        _labelNameArray = @[@"titleLabel", @"contentLabel", @"desLabel"];
    }
    return _labelNameArray;
}

//- (NSDictionary *)controlDict
//{
//    return @{ self.labelFindIdentify : @(PsdControlTypeLabel),
//              self.buttonFindIdentify : @(PsdControlTypeButton),
//              self.imageViewFindIdentify : @(PsdControlTypeImageView),
//              self.viewFindIdentify : @(PsdControlTypeView),
//              self.cellFindIdentify : @(PsdControlTypeCell),
//              self.textFieldFindIdentify : @(PsdControlTypeTextField),
//              self.scrollViewFindIdentify : @(PsdControlTypeScrollView)
//              };
//}

- (NSString *)clickKey
{
    return @"click";
}

@end
