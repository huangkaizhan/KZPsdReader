//
//  PsdCustomControlModel.h
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/19.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PsdControlModel.h"

@interface PsdCustomControlModel : PsdControlModel

/** 子控件*/
@property (nonatomic, strong) NSMutableArray <PsdControlModel *>*subControlModelArray;

/** 继承哪个控件名称，默认为UIView*/
@property (nonatomic, copy) NSString *superControlName;

/** 自定义控件文件名*/
@property (nonatomic, copy) NSString *fileName;

/** 文件创建字符传*/
@property (nonatomic, copy) NSString *controlFileString;

/** 文字变量名数组*/
@property (nonatomic, strong) NSMutableArray <NSString *>*labelNameArrayM;

/** 引入自定义类代码 : #import "..."*/
@property (nonatomic, copy) NSMutableString *controlForImportClassString;

/**
 更新控件类型名称

 @param className 类名
 */
- (void)updateClassName:(NSString *)className;
@end
