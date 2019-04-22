//
//  PsdMakerConfigModel.h
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/21.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PsdMakerConfigModel : NSObject

/**
 文件名
 */
@property (nonatomic, copy) NSString *fileName;

/**
 作者名
 */
@property (nonatomic, copy) NSString *authorName;

/**
 url链接
 */
@property (nonatomic, copy) NSString *urlString;

@end
