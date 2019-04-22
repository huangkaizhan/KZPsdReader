//
//  PsdMakerRepository.m
//  PsdReader
//
//  Created by huang kaizhan on 2017/12/31.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdMakerRepository.h"
#import "PsdControlModel.h"
#import "PsdViewMaker.h"
#import "PsdButtonMaker.h"
#import "PsdScrollViewMaker.h"
#import "PsdEmptyMaker.h"

@implementation PsdMakerRepository

SingletonM_lib(Repository);

ObjectCreate_Psd(PsdLabelMaker, labelMaker, _labelMaker);
ObjectCreate_Psd(PsdImageViewMaker, imageViewMaker, _imageViewMaker);

+ (PsdBaseMaker *)makerWithControlModel:(PsdControlModel *)controlModel
{
    PsdBaseMaker *maker = nil;
    switch (controlModel.controlType) {
        case PsdControlTypeView:
            maker = [[PsdViewMaker alloc] initWithControlModel:controlModel];
            break;
        case PsdControlTypeLabel:
            maker = [[PsdLabelMaker alloc] initWithControlModel:controlModel];
            break;
        case PsdControlTypeImageView:
            maker = [[PsdImageViewMaker alloc] initWithControlModel:controlModel];
            break;
        case PsdControlTypeButton:
            maker = [[PsdButtonMaker alloc] initWithControlModel:controlModel];
            break;
        case PsdControlTypeScrollView:
            maker = [[PsdScrollViewMaker alloc] initWithControlModel:controlModel];
            break;
        default:
            maker = [[PsdEmptyMaker alloc] initWithControlModel:controlModel];
            break;
    }
    return maker;
}
@end
