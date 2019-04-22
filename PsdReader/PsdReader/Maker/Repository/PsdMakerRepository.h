//
//  PsdMakerRepository.h
//  PsdReader
//
//  Created by huang kaizhan on 2017/12/31.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton_lib.h"
#import "PsdLabelMaker.h"
#import "PsdImageViewMaker.h"
@class PsdControlModel;

/**
 创建器仓库
 */
@interface PsdMakerRepository : NSObject

SingletonH_lib(Repository);

@property (nonatomic, strong) PsdLabelMaker *labelMaker;

@property (nonatomic, strong) PsdImageViewMaker *imageViewMaker;

+ (PsdBaseMaker *)makerWithControlModel:(PsdControlModel *)controlModel;
@end
