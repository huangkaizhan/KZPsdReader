//
//  PsdControlFileMaker.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/19.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdControlFileMaker.h"
#import "PsdCustomControlModel.h"

@interface PsdControlFileMaker()

@end

@implementation PsdControlFileMaker

- (PsdCustomControlModel *)customControlModel
{
    return (PsdCustomControlModel *)self.controlModel;
}

#pragma mark - 文件
//- (NSString *)fileDemoName
//{
//    return [self.childModel.controlModel.fileName stringByAppendingString:@"Demo.h"];
//}
//
- (NSString *)directoryPath
{
    return [PsdFileTool createDirectoryWithName:self.customControlModel.fileName];
}

#pragma mark - h文件字符串
// 获取默认.h文件字符串
- (NSMutableString *)getDefaultHFileString
{
    NSMutableString *hString = [self getDefaultHFileStringWithoutEndString];
    [hString appendString:ForMatterEnd];
    return hString;
}

// 获取默认.h文件字符串, 不带@end字符串
- (NSMutableString *)getDefaultHFileStringWithoutEndString
{
    NSMutableString *hString = [NSMutableString string];
    [hString appendString:[self getHFileAnnotationHeader]];
    [hString appendString:ForMatterInterfaceHWithControlName(self.customControlModel.fileName, self.customControlModel.superControlName)];
    return hString;
}

// 获取.h文件头部注释
- (NSMutableString *)getHFileAnnotationHeader
{
    NSMutableString *annotationString = [NSMutableString string];
    [annotationString appendString:ForMatterImportSystem];
    [annotationString insertString:[PsdStringFormatter getAnomationWithFileName:self.customControlModel.fileName anthorName:self.configModel.authorName isHFile:YES] atIndex:0];
    return annotationString;
}

#pragma mark - m文件字符串
// 获取默认.m文件字符串
- (NSMutableString *)getDefaultMFileString
{
    NSMutableString *mString = [self getDefaultMFileStringWithEndString];
    [mString appendString:ForMatterEnd];
    return mString;
}

- (NSMutableString *)getDefaultMFileInterfaceWithoutEndString
{
    NSMutableString *mString = [NSMutableString string];
    [mString appendString:[self getMFileAnnotationHeader]];
    [mString appendString:ForMatterInterfaceM(self.customControlModel.fileName)];
    return mString;
}

- (NSString *)getDefaultMFileImplementationWithoutEndString
{
    return ForMatterImplementation(self.customControlModel.fileName);
}

// 获取默认.m文件字符串, 不带@end字符串
- (NSMutableString *)getDefaultMFileStringWithEndString
{
    NSMutableString *mString = [NSMutableString string];
    [mString appendString:[self getMFileAnnotationHeader]];
    [mString appendString:ForMatterInterfaceM(self.customControlModel.fileName)];
    [mString appendString:ForMatterEnd];
    [mString appendString:[self getDefaultMFileImplementationWithoutEndString]];
    return mString;
}

// 获取.m文件头部注释
- (NSMutableString *)getMFileAnnotationHeader
{
    NSMutableString *annotationString = [NSMutableString string];
    [annotationString appendFormat:@"\r\n#import \"%@.h\"", self.customControlModel.fileName];
    [annotationString appendString:[PsdStringFormatter getImportMasonryString]];
    [annotationString appendString:[PsdStringFormatter getImportSDWebImageString]];
    [annotationString insertString:[PsdStringFormatter getAnomationWithFileName:self.customControlModel.fileName anthorName:self.configModel.authorName isHFile:NO] atIndex:0];
    return annotationString;
}

// 引入自定义类代码
- (NSMutableString *)createImportString
{
    NSMutableString *methodString = [NSMutableString string];
    [methodString appendFormat:@"\r\n#import \"%@.h\"", self.customControlModel.fileName];
    return methodString;
}

// 获取初始化的代码
- (NSMutableString *)getInitString
{
    if (self.customControlModel.controlType == PsdControlTypeCell) {
        return [self getInitStyleString];
    } else {
        return [self getInitFrameString];
    }
}

- (NSMutableString *)getInitStyleString
{
    NSMutableString *initString = [NSMutableString string];
    [initString appendFormat:@"- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier%@{%@%@self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];%@%@if (self){%@", KeyLineFeed, KeyLineFeed, KeySpace, KeyLineFeed, KeySpace, KeyLineFeed];
    [initString appendFormat:@"\r\n%@%@[self prepareUI];", KeySpace, KeySpace];
    [initString appendFormat:@"\r\n%@%@self.clipsToBounds = YES;", KeySpace, KeySpace];
    [initString appendFormat:@"%@%@}%@%@return self;%@}%@", KeyLineFeed, KeySpace, KeyLineFeed, KeySpace, KeyLineFeed, KeyLineFeed];
    return initString;
}

- (NSMutableString *)getInitFrameString
{
    NSMutableString *initString = [NSMutableString string];
    [initString appendString:ForMatterInitWithFrameBegin];
    [initString appendFormat:@"\r\n%@%@[self prepareUI];", KeySpace, KeySpace];
    [initString appendFormat:@"\r\n%@%@self.clipsToBounds = YES;\r\n", KeySpace, KeySpace];
    if (self.canClick) {
        // 子控件直接添加手势
        [initString appendFormat:@"%@UITapGestureRecognizer *%@TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(%@Tap:)];%@",KeySpace,  self.controlVarName, self.controlVarName, KeyLineFeed];
        [initString appendFormat:@"%@[self addGestureRecognizer:%@TapGesture];%@",KeySpace, self.controlVarName, KeyLineFeed];
    }
    [initString appendString:ForMatterInitWithFrameEnd];
    return initString;
}

// 点击方法事件
- (NSMutableString *)createTapMethodEventString
{
    NSMutableString *string = [NSMutableString string];
    if (self.canClick) {
        [string appendFormat:@"%@// <#zhushi#>%@",KeyLineFeed, KeyLineFeed];
        [string appendFormat:@"- (void)%@Tap:(UITapGestureRecognizer *)gesture%@{%@",self.controlVarName, KeyLineFeed, KeyLineFeed];
        [string appendFormat:@"%@if (self.tapBlock%@) {%@", KeySpace, KeySpace, KeyLineFeed];
        [string appendFormat:@"%@%@self.tapBlock();%@", KeySpace, KeySpace, KeyLineFeed];
        [string appendFormat:@"%@}%@}", KeySpace, KeyLineFeed];
    }
    return string;
}
@end
