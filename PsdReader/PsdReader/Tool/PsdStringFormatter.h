//
//  PsdStringFormatter.h
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/27.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ForMatterImportSystem                                           [PsdStringFormatter getImportSystemString]
#define ForMatterInterfaceH(className)                                  [PsdStringFormatter getInterfaceHWithClassName:className]
#define ForMatterInterfaceHWithControlName(className, controlName1)       [PsdStringFormatter getInterfaceHWithClassName:className controlName:controlName1]
#define ForMatterInterfaceM(className)                                  [PsdStringFormatter getInterfaceMWithClassName:className]
#define ForMatterImplementation(className)                              [PsdStringFormatter getImplementationMWithClassName:className]
#define ForMatterEnd                                                    [PsdStringFormatter getEnd]
#define ForMatterViewProperty(controlName)                              [PsdStringFormatter getPropertyForViewWithControlName:controlName]
#define ForMatterButtonProperty(controlName)                            [PsdStringFormatter getPropertyForButtonWithControlName:controlName]
#define ForMatterLabelProperty(controlName)                             [PsdStringFormatter getPropertyForLabelWithControlName:controlName]
#define ForMatterImageViewProperty(controlName)                         [PsdStringFormatter getPropertyForImageViewWithControlName:controlName]
#define ForMatterTextFieldProperty(controlName)                         [PsdStringFormatter getPropertyForTextFieldWithControlName:controlName]
#define ForMatterScrollViewProperty(controlName)                        [PsdStringFormatter getPropertyForScrollViewWithControlName:controlName]
#define ForMatterInitWithFrameBegin                                     [PsdStringFormatter getInitFrameBeginString]
#define ForMatterInitWithFrameEnd                                       [PsdStringFormatter getInitFrameEndString]
#define ForMatterAwakeNibBegin                                          [PsdStringFormatter getInitAwakeNibBeginString]
#define ForMatterAwakeNibEnd                                            [PsdStringFormatter getInitAwakeNibEndString]


#pragma mark - 布局
#define FormatterLayoutFactorDefine                                     ([PsdSettingModel sharedModel].isEnableLayoutFactor ? @"CGFloat factor = [UIScreen mainScreen].bounds.size.width / 375.0;" : @"")
#define FormatterLayoutFactor                                           ([PsdSettingModel sharedModel].isEnableLayoutFactor ? @" * factor" : @"")

@interface PsdStringFormatter : NSObject

#pragma mark - 头文件/头注释
/**
 获取引入系统头文件

 @return 字符串
 */
+ (NSString *)getImportSystemString;

/**
 获取引入Masonry头文件

 @return 字符串
 */
+ (NSString *)getImportMasonryString;

/**
 获取引入SDWebImage头文件
 
 @return 字符串
 */
+ (NSString *)getImportSDWebImageString;

/**
 获取引入MJRefresh头文件
 
 @return 字符串
 */
+ (NSString *)getImportMJRefreshString;

/**
 获取文件头注释

 @param fileName 文件名
 @param anthorName 作者名
 @param isHFile 是h文件还是m文件
 @return 字符串
 */
+ (NSString *)getAnomationWithFileName:(NSString *)fileName anthorName:(NSString *)anthorName isHFile:(BOOL)isHFile;

#pragma mark - interface/implementation
/**
 获取h文件的interface字符串 -> @ interface PsdStringFormatter : UIView

 @param name 类名
 @return 字符串
 */
+ (NSString *)getInterfaceHWithClassName:(NSString *)name;

/**
 获取h文件的interface字符串 -> @ interface PsdStringFormatter : controlName

 @param name 类名
 @param controlName 父控件名
 @return 字符串
 */
+ (NSString *)getInterfaceHWithClassName:(NSString *)name controlName:(NSString *)controlName;

/**
 获取m文件的interface字符串 -> @ implementation PsdStringFormatter

 @param name 类名
 @return 字符串
 */
+ (NSString *)getInterfaceMWithClassName:(NSString *)name;


/**
 获取m文件的implementation字符串 -> @ implementation PsdStringFormatter

 @param name 类名
 @return 字符串
 */
+ (NSString *)getImplementationMWithClassName:(NSString *)name;

/**
 获取end字符串
 */
+ (NSString *)getEnd;

#pragma mark - 属性

/**
 获取UIView的属性字符串

 @param controlName 控件名称
 @return 字符串
 */
+ (NSString *)getPropertyForViewWithControlName:(NSString *)controlName;

/**
 获取UIButton的属性字符串
 
 @param controlName 控件名称
 @return 字符串
 */
+ (NSString *)getPropertyForButtonWithControlName:(NSString *)controlName;

/**
 获取UILabel的属性字符串
 
 @param controlName 控件名称
 @return 字符串
 */
+ (NSString *)getPropertyForLabelWithControlName:(NSString *)controlName;

/**
 获取UIImageView的属性字符串
 
 @param controlName 控件名称
 @return 字符串
 */
+ (NSString *)getPropertyForImageViewWithControlName:(NSString *)controlName;

/**
 获取UITextField的属性字符串
 
 @param controlName 控件名称
 @return 字符串
 */
+ (NSString *)getPropertyForTextFieldWithControlName:(NSString *)controlName;

/**
 获取ScrollView的属性字符串
 
 @param controlName 控件名称
 @return 字符串
 */
+ (NSString *)getPropertyForScrollViewWithControlName:(NSString *)controlName;

/**
 取控件属性字符串

 @param className 类名
 @param controlName 控件变量名
 @param controlNote 注释
 @return 字符串
 */
+ (NSString *)getPropertyWithClassName:(NSString *)className controlName:(NSString *)controlName controlNote:(NSString *)controlNote;

/**
 获取控件属性字符串

 @param controlType 控件类型
 @param controlName 控件名称
 @param controlNote 控件注释
 @return 字符串
 */
+ (NSString *)getPropertyWithControlType:(PsdControlType)controlType controlName:(NSString *)controlName controlNote:(NSString *)controlNote;

#pragma mark - 初始化
/**
 获取initWithFrame开始字符串

 @return 字符串
 */
+ (NSString *)getInitFrameBeginString;

/**
 获取initWithFrame结束字符串
 
 @return 字符串
 */
+ (NSString *)getInitFrameEndString;

/**
 获取awakeFromNib开始字符串
 
 @return 字符串
 */
+ (NSString *)getInitAwakeNibBeginString;

/**
 获取awakeFromNib结束字符串
 
 @return 字符串
 */
+ (NSString *)getInitAwakeNibEndString;
@end
