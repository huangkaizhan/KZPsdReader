//
//  PsdGroupModel.m
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/19.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdChildModel.h"
#import "MJExtension.h"
#import "PsdNetTool.h"

@implementation PsdChildModel

+ (NSDictionary *)objectClassInArray
{
    return @{ @"children" : [PsdChildModel class] };
}

- (void)setType:(NSString *)type
{
    _type = type;
    self.isLayer = [type isEqualToString:@"layer"];
}

- (void)setName:(NSString *)name
{
    _name = name;
    // 过滤控件翻译
    NSString *newName = name;
    if ([name isEqualToString:@"我放弃"]) {
        NSLog(@"");
    }
    NSRange range = NSMakeRange(0, 0);
    if ([newName containsString:Control_View_Name_Find]) {
        range = [newName rangeOfString:Control_View_Name_Find];
    } else if ([newName containsString:Control_Label_Name_Find]) {
        range = [newName rangeOfString:Control_Label_Name_Find];
    } else if ([newName containsString:Control_Button_Name_Find]) {
        range = [newName rangeOfString:Control_Button_Name_Find];
    } else if ([newName containsString:Control_ImageView_Name_Find]) {
        range = [newName rangeOfString:Control_ImageView_Name_Find];
    } else if ([newName containsString:Control_Cell_Name_Find]) {
        range = [newName rangeOfString:Control_Cell_Name_Find];
    }  else if ([newName containsString:Control_ScrollView_Name_Find]) {
        range = [newName rangeOfString:Control_ScrollView_Name_Find];
    }  else if ([newName containsString:Control_TextField_Name_Find]) {
        range = [newName rangeOfString:Control_TextField_Name_Find];
    }
    if (range.length) {
        newName = [newName substringToIndex:range.location];
    }
    
    // 过滤无效符号
    for (NSInteger i = 0; i < [PsdStandardRepository sharedRepository].invalidValNameArray.count; i++) {
        NSString *number = [PsdStandardRepository sharedRepository].invalidValNameArray[i];
        range = [newName rangeOfString:number];
        if (range.length) {
            newName = [newName stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    // 过滤开头数字
    range = [newName rangeOfString:@"^[0-9]*" options:NSRegularExpressionSearch];
    if (range.length) {
        newName = [newName substringFromIndex:range.length];
    }
    WeakSelf_Psd
    [PsdNetTool translateWithText:newName completionBlock:^(PsdTranslateModel *model) {
        weakSelf.translateName = model.result;
        if (weakSelf.translateCompletionBlock) {
            weakSelf.translateCompletionBlock(weakSelf.translateName);
        }
    }];
}

- (CGFloat)height
{
    // 处理tabbar
    if (!self.isLayer && ([self.name isEqualToString:@"tab"] || [self.name isEqualToString:@"tabbar"])) {
        _height = 98;
    }
    return _height;
}

@end
