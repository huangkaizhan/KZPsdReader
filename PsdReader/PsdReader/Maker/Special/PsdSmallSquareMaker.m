//
//  TransSmallSquareTool.m
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/20.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "PsdSmallSquareMaker.h"


@implementation PsdSmallSquareMaker

- (NSString *)fileName
{
    return @"SmallSquareView";
}

// 根据psd模型生成
- (void)create
{
//    CGFloat squareHeight = self.childModel.iOS_height;
//    CGFloat iconWidth = 0;
//    CGFloat iconHeight = 0;
//    BOOL hasExample = NO;
//    // 真实小方块数组，去掉了用例
//    NSMutableArray *realSquareArray = [NSMutableArray arrayWithArray:self.childModel.children];
//    // 获取图标匡高
//    for (NSInteger i = 0; i < self.childModel.children.count; i++) {
//        PsdChildModel *childModel = self.childModel.children[i];
//        if ([childModel.name containsString:@"示例"]) {
//            // 获取宽高
//            iconWidth = childModel.iOS_width;
//            iconHeight = childModel.iOS_height;
//            hasExample = YES;
//            [realSquareArray removeObject:childModel];
//        }
//        if (!childModel.visible) {
//            [realSquareArray removeObject:childModel];
//        }
//    }
//    NSAssert(hasExample, @"没有小方块示例，标准不对");
//    // 开始遍历创建所有小方块
//    NSMutableString *foreachCreateSmallSquareString = [NSMutableString string];
//    [foreachCreateSmallSquareString appendFormat:@"        CGFloat factor = [UIScreen mainScreen].bounds.size.width / %@;%@", KeyStandardWidth, KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"        CGFloat leftMargin = %.2f;%@", self.childModel.iOS_left, KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"        CGFloat x = 0;%@", KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"        CGFloat y = 0;%@", KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"        CGFloat width = %.2f * factor;%@", iconWidth, KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"        CGFloat height = %.2f * factor;%@", squareHeight, KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"        CGFloat allWidth = [UIScreen mainScreen].bounds.size.width - leftMargin * 2;%@", KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"        CGFloat margin = (allWidth - (width * %zd)) / (%zd - 1);%@", realSquareArray.count, realSquareArray.count, KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"        for (NSInteger i = 0; i < %zd; i++) {%@", realSquareArray.count, KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"            x = (width + margin) * i + leftMargin;%@", KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"            %@ *view = [[%@ alloc] initWithFrame:CGRectMake(x, y, width, height)];%@", self.fileName, self.fileName, KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"            [self addSubview:view];%@", KeyLineFeed];
//    [foreachCreateSmallSquareString appendFormat:@"        }%@", KeyLineFeed];
//    // 写入文件
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@", self.directoryPath, self.fileDemoName];
//    [foreachCreateSmallSquareString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//
//    [self createCodeWithPsdModel:realSquareArray.firstObject];
}

// 以xib形式创建，结果为xib，h，m，xib布局
- (void)createXibWithPsdModel:(PsdChildModel *)model
{
    
}

// 以代码形式创建，结果为h，m，代码布局
- (void)createCodeWithPsdModel:(PsdChildModel *)squareModel
{
//    // 获取正确的文字模型
//    NSAssert(squareModel.children.count, @"小方块格式不正确");
//    PsdChildModel *model = nil;
//    for (PsdChildModel *childModel in squareModel.children) {
//        if (childModel.text) {
//            model = childModel;
//            break;
//        }
//    }
//    // 文字名
//    NSString *labelName = @"titleLabel";
//    NSString *imageViewName = @"iconImageView";
//
//    // h文件处理
//    NSMutableString *hString = [self getDefaultHFileString];
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@.h", self.directoryPath, self.fileName];
//    [hString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//
//    // m文件处理
//    NSMutableString *mString = [self getMFileAnnotationHeader];
//    [mString appendFormat:@"#import \"%@\"%@", self.fileName, KeyLineFeed];
//    // 属性
//    [mString appendString:ForMatterInterfaceM(self.fileName)];
//    [mString appendString:ForMatterImageViewProperty(imageViewName)];
//    [mString appendString:ForMatterLabelProperty(labelName)];
//    [mString appendString:ForMatterEnd];
//
//    // @implementation
//    [mString appendString:ForMatterImplementation(self.fileName)];
//
//    // initWithFrame
//    [mString appendString:ForMatterInitWithFrameBegin];
//    [mString appendFormat:@"        // 图标%@", KeyLineFeed];
//    [mString appendFormat:@"        [self prepareIcon];%@", KeyLineFeed];
//    [mString appendFormat:@"        // 内容%@", KeyLineFeed];
//    [mString appendFormat:@"        [self prepareContentLabel];%@", KeyLineFeed];
//    [mString appendString:ForMatterInitWithFrameEnd];
//
//    // prepareIcon
//    [mString appendFormat:@"%@// 图标%@", KeyLineFeed, KeyLineFeed];
//    [mString appendFormat:@"- (void)prepareIcon%@", KeyLineFeed];
//    [mString appendFormat:@"{%@", KeyLineFeed];
//    [PsdMakerRepository sharedRepository].imageViewMaker.childModel = model;
//    NSMutableString *imageViewString = [[PsdMakerRepository sharedRepository].imageViewMaker getControlStringWithSpace:@"    " controlName:imageViewName isFactor:YES];
//    [mString appendString:imageViewString];
//    [mString appendFormat:@"    [self addSubview:iconImageView];%@", KeyLineFeed];
//    [mString appendFormat:@"    __weak typeof (self) weakSelf = self;%@", KeyLineFeed];
//    [mString appendFormat:@"    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {%@", KeyLineFeed];
//    [mString appendFormat:@"        make.width.top.left.equalTo(weakSelf);%@", KeyLineFeed];
//    [mString appendFormat:@"        make.height.equalTo(weakSelf.mas_width);%@", KeyLineFeed];
//    [mString appendFormat:@"    }];%@", KeyLineFeed];
//    [mString appendFormat:@"}%@%@", KeyLineFeed, KeyLineFeed];
//
//    // prepareContentLabel
//    [mString appendFormat:@"%@// 内容%@", KeyLineFeed, KeyLineFeed];
//    [mString appendFormat:@"- (void)prepareContentLabel%@", KeyLineFeed];
//    [mString appendFormat:@"{%@", KeyLineFeed];
//    [PsdMakerRepository sharedRepository].labelMaker.childModel = model;
//    NSMutableString *labelString = [[PsdMakerRepository sharedRepository].labelMaker getControlStringWithSpace:@"    " controlName:labelName isFactor:YES];
//    [mString appendString:labelString];
//    [mString appendFormat:@"    [self addSubview:%@];%@", labelName, KeyLineFeed];
//    [mString appendFormat:@"    self.%@ = %@;%@", labelName, labelName, KeyLineFeed];
//    [mString appendFormat:@"    __weak typeof (self) weakSelf = self;%@", KeyLineFeed];
//    [mString appendFormat:@"    [%@ mas_makeConstraints:^(MASConstraintMaker *make) {%@", labelName, KeyLineFeed];
//    [mString appendFormat:@"        make.top.mas_equalTo(%f * factor);%@", model.iOS_top, KeyLineFeed];
//    [mString appendFormat:@"        make.centerX.equalTo(weakSelf);%@", KeyLineFeed];
//    [mString appendFormat:@"    }];%@", KeyLineFeed];
//    [mString appendFormat:@"}%@", KeyLineFeed];
//    [mString appendFormat:@"%@", KeyLineFeed];
//    [mString appendString:ForMatterEnd];
//
//    // 创建文件
//    filePath = [NSString stringWithFormat:@"%@/%@.m", self.directoryPath, self.fileName];
//    [mString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
@end
