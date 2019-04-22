//
//  PsdStringFormatter.m
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/27.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdStringFormatter.h"
#import "NSDate+Category_lib.h"

@implementation PsdStringFormatter

#pragma mark - 头文件
// 获取引入头文件
+ (NSString *)getImportSystemString
{
    return [NSString stringWithFormat:@"%@%@#import <Foundation/Foundation.h>%@#import <UIKit/UIKit.h>%@", KeyLineFeed, KeyLineFeed, KeyLineFeed, KeyLineFeed];
}

// 获取引入Masonry头文件
+ (NSString *)getImportMasonryString
{
    return @"\r\n#import \"Masonry.h\"";
}

// 获取引入SDWebImage头文件
+ (NSString *)getImportSDWebImageString
{
//    return @"\r\n#import \"UIImageView+WebCache.h\"";
    return @"";
}

// 获取引入MJRefresh头文件
+ (NSString *)getImportMJRefreshString
{
    return @"#import \"MJRefresh.h\"";
}

// 获取文件头注释
+ (NSString *)getAnomationWithFileName:(NSString *)fileName anthorName:(NSString *)anthorName isHFile:(BOOL)isHFile
{
    NSString *msg = isHFile ? @"h" : @"m";
    NSString *dateString = [[NSDate date] formatYearMonthDay_lib];
    NSString *yearString = [dateString substringToIndex:[dateString rangeOfString:@"-"].location];
    NSMutableString *anomationString = [NSMutableString string];
    [anomationString appendFormat:@"//%@", KeyLineFeed];
    [anomationString appendFormat:@"//  %@.%@%@//%@", fileName, msg, KeyLineFeed, KeyLineFeed];
    [anomationString appendFormat:@"//  Created by %@ on %@.%@", anthorName, dateString, KeyLineFeed];
    [anomationString appendFormat:@"//  Created by PsdReader anthor : 黄凯展 on %@.%@", dateString, KeyLineFeed];
    [anomationString appendFormat:@"//  Copyright © %@年 %@. All rights reserved.%@//%@", yearString, anthorName, KeyLineFeed, KeyLineFeed];
    return anomationString;
}

#pragma mark - interface/implementation
// 获取h文件的interface字符串 -> @ interface PsdStringFormatter : UIView
+ (NSString *)getInterfaceHWithClassName:(NSString *)name
{
    return [self getInterfaceHWithClassName:name controlName:Control_View_Name_Control];
}

// 获取h文件的interface字符串 -> @ interface PsdStringFormatter : controlName
+ (NSString *)getInterfaceHWithClassName:(NSString *)name controlName:(NSString *)controlName
{
    return [NSString stringWithFormat:@"%@%@@interface %@ : %@%@", KeyLineFeed, KeyLineFeed, name, controlName, KeyLineFeed];
}


// 获取m文件的interface字符串 -> @ implementation PsdStringFormatter
+ (NSString *)getInterfaceMWithClassName:(NSString *)name
{
    return [NSString stringWithFormat:@"%@%@@interface %@()%@", KeyLineFeed, KeyLineFeed, name, KeyLineFeed];
}

// 获取m文件的implementation字符串 -> @ implementation PsdStringFormatter
+ (NSString *)getImplementationMWithClassName:(NSString *)name
{
    return [NSString stringWithFormat:@"%@@implementation %@%@%@", KeyLineFeed, name, KeyLineFeed, KeyLineFeed];
}

// 获取end字符串
+ (NSString *)getEnd
{
    return @"\r\n@end\r\n";
}

#pragma mark - 属性
+ (NSString *)getPropertyForViewWithControlName:(NSString *)controlName
{
    return [self getPropertyWithClassName:Control_View_Name_Control controlName:controlName controlNote:@""];
}

+ (NSString *)getPropertyForButtonWithControlName:(NSString *)controlName
{
    return [self getPropertyWithClassName:Control_Button_Name_Control controlName:controlName controlNote:@""];
}

+ (NSString *)getPropertyForLabelWithControlName:(NSString *)controlName
{
    return [self getPropertyWithClassName:Control_Label_Name_Control controlName:controlName controlNote:@""];
}

+ (NSString *)getPropertyForImageViewWithControlName:(NSString *)controlName
{
    return [self getPropertyWithClassName:Control_ImageView_Name_Control controlName:controlName controlNote:@""];
}
// 获取UITextField的属性字符串
+ (NSString *)getPropertyForTextFieldWithControlName:(NSString *)controlName
{
    return [self getPropertyWithClassName:Control_TextField_Name_Control controlName:controlName controlNote:@""];
}

// 获取ScrollView的属性字符串
+ (NSString *)getPropertyForScrollViewWithControlName:(NSString *)controlName
{
    return [self getPropertyWithClassName:Control_ScrollView_Name_Control controlName:controlName controlNote:@""];
}

// 获取控件属性字符串
+ (NSString *)getPropertyWithClassName:(NSString *)className controlName:(NSString *)controlName controlNote:(NSString *)controlNote
{
    if (!className.length || !controlName.length) {
        return @"";
    }
    // 是否带注释
    if (controlNote.length) {
        return [NSString stringWithFormat:@"/** %@*/%@@property (nonatomic, strong) %@ *%@;%@", controlNote, KeyLineFeed, className, controlName, KeyLineFeed];
    } else {
        return [NSString stringWithFormat:@"/** <#zhushi#>*/%@@property (nonatomic, strong) %@ *%@;%@", KeyLineFeed, className, controlName, KeyLineFeed];
    }
}

+ (NSString *)getPropertyWithControlType:(PsdControlType)controlType controlName:(NSString *)controlName controlNote:(NSString *)controlNote
{
    NSString *className = @"";
    switch (controlType) {
        case PsdControlTypeView:
            className = Control_View_Name_Control;
            break;
        case PsdControlTypeLabel:
            className = Control_Label_Name_Control;
            break;
        case PsdControlTypeButton:
            className = Control_Button_Name_Control;
            break;
        case PsdControlTypeImageView:
            className = Control_ImageView_Name_Control;
            break;
        case PsdControlTypeTextField:
            className = Control_TextField_Name_Control;
            break;
        case PsdControlTypeScrollView:
            className = Control_ScrollView_Name_Control;
            break;
        case PsdControlTypeCell:
        case PsdControlTypeNone:
            className = @"";
            break;
        default:
            NSAssert(1 == 2, @"写少控件类型判断");
            break;
    }
    return [self getPropertyWithClassName:className controlName:controlName controlNote:controlNote];
}

#pragma mark - 初始化
+ (NSString *)getInitFrameBeginString
{
    NSMutableString *stringM = [NSMutableString string];
    [stringM appendFormat:@"- (instancetype)initWithFrame:(CGRect)frame%@", KeyLineFeed];
    [stringM appendFormat:@"{%@", KeyLineFeed];
    [stringM appendFormat:@"    self = [super initWithFrame:frame];%@", KeyLineFeed];
    [stringM appendFormat:@"    if (self) {%@", KeyLineFeed];
    return stringM;
}

+ (NSString *)getInitFrameEndString
{
    NSMutableString *stringM = [NSMutableString string];
    [stringM appendFormat:@"%@    }%@", KeyLineFeed, KeyLineFeed];
    [stringM appendFormat:@"    return self;%@", KeyLineFeed];
    [stringM appendFormat:@"}%@", KeyLineFeed];
    return stringM;
}

+ (NSString *)getInitAwakeNibBeginString
{
    NSMutableString *stringM = [NSMutableString string];
    [stringM appendFormat:@"%@- (void)awakeFromNib%@", KeyLineFeed, KeyLineFeed];
    [stringM appendFormat:@"{%@", KeyLineFeed];
    [stringM appendFormat:@"    [super awakeFromNib];%@", KeyLineFeed];
    return stringM;
}

+ (NSString *)getInitAwakeNibEndString
{
    return @"\r\n}\r\n";
}
@end
