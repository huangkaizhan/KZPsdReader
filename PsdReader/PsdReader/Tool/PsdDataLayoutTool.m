//
//  PsdDataLayoutTool.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/2/5.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdDataLayoutTool.h"
#import "PsdCustomControlModel.h"

@implementation PsdDataLayoutTool

/**
 处理父控件下的子控件布局
 
 @param superModelArray 父控件模型数组
 */
+ (void)handleSubControlLayoutWithSuperControlArray:(NSArray *)superModelArray
{
    for (PsdCustomControlModel *superModel in superModelArray) {
        if (!superModel.subControlModelArray.count) {
            continue;
        }
        [self handleLayoutWithSuperModel:superModel];
    }
}

+ (void)handleLayoutWithSuperModel:(PsdCustomControlModel *)superModel
{
    // 处理行数组 ： 行数组确定x和对齐的y值
    [self handleRowControlLayoutWithSuperModel:superModel];
    
    // 处理列数组 ： 列数组确定y和对齐的x值
    [self handleColControlLayoutWithSuperModel:superModel];
}

+ (void)handleRowControlLayoutWithSuperModel:(PsdCustomControlModel *)superModel
{
    // 遍历子控件, 排序，从小到大
    [superModel.subControlModelArray sortUsingComparator:^NSComparisonResult(PsdControlModel *model1, PsdControlModel *model2) {
        if (model1.layoutModel.top == model2.layoutModel.top) {
            return model1.layoutModel.left > model2.layoutModel.left;
        }
        return model1.layoutModel.top > model2.layoutModel.top;
    }];
    if ([superModel.originName isEqualToString:@"弹窗2view"]) {
        NSLog(@"");
    }
    // 确定最后一个控件，用来做底部布局
    superModel.subControlModelArray.lastObject.layoutModel.isLastControl = YES;
    // 分配行数组 ： 行数组确定x和对齐的y值
    NSMutableArray *allRowArray = [NSMutableArray array];
    NSMutableArray *rowArray = [NSMutableArray array];
    [allRowArray addObject:rowArray];
    PsdControlModel *rowFirstModel = superModel.subControlModelArray.firstObject;
    [rowArray addObject:rowFirstModel];
    for (NSInteger i = 1; i < superModel.subControlModelArray.count; i++) {
        PsdControlModel *compareModel = superModel.subControlModelArray[i];
        // 这里的compareModel的y值肯定比rowFirstModel的y值大，因为已经有过排序
        if (compareModel.layoutModel.top <= rowFirstModel.layoutModel.maxY) {
            // 同一行, 加入行数组
            [rowArray addObject:compareModel];
        } else {
            // 不是同一行，要另起行数组
            rowArray = [NSMutableArray array];
            rowFirstModel = compareModel;
            [rowArray addObject:rowFirstModel];
            [allRowArray addObject:rowArray];
        }
    }
    
    // 所有行数组按x排序，从小到大
    for (NSMutableArray *rowArray in allRowArray) {
        
        if (rowArray.count < 2) {
            // 单行控件
            PsdControlModel *controlModel = rowArray.firstObject;
            controlModel.layoutModel.isSingleLineControl = YES;
            continue;
        }
        
        [rowArray sortUsingComparator:^NSComparisonResult(PsdControlModel *model1, PsdControlModel *model2) {
            return model1.layoutModel.left > model2.layoutModel.left;
        }];
        
        
        // 确定行数组的x和对齐的y值
        // 分离左右行数组
        NSMutableArray *rowLeftArray = [NSMutableArray array];
        NSMutableArray *rowRightArray = [NSMutableArray array];
        PsdControlModel *relativeModel = rowArray.firstObject;
        if ([self isUseRightLayoutWithModel:relativeModel]) {
            relativeModel.layoutModel.userRightLayout = YES;
            [rowRightArray addObject:relativeModel];
        } else {
            relativeModel.layoutModel.userRightLayout = NO;
            [rowLeftArray addObject:relativeModel];
        }
        for (NSInteger i = 1; i < rowArray.count; i++) {
            PsdControlModel *compareModel = rowArray[i];
            // 判断上一个是否右边布局, 那么这个compareModel也是右边布局，因为已经按x值排序过
            if (relativeModel.layoutModel.userRightLayout) {
                // 直接承接上一个的右边布局
                compareModel.layoutModel.userRightLayout = YES;
                [rowRightArray addObject:compareModel];
                relativeModel.layoutModel.relativeRightModel = compareModel; // 相对右边布局的模型要反过来
            } else {
                // 跟左边的控件距离超过20, 并且x大于一半
                if (compareModel.layoutModel.left - relativeModel.layoutModel.maxX > 20 && [self isUseRightLayoutWithModel:compareModel]) {
                    // 修改模型为右布局模型
                    compareModel.layoutModel.userRightLayout = YES;
                    if (relativeModel.controlType == PsdControlTypeLabel) {
                        relativeModel.layoutModel.relativeRightModel = compareModel;
                    }
                    [rowRightArray addObject:compareModel];
                } else {
                    compareModel.layoutModel.userRightLayout = NO;
                    compareModel.layoutModel.relativeLeftModel = relativeModel;
                    [rowLeftArray addObject:compareModel];
                }
            }
            relativeModel = compareModel;
        }
        
        [rowArray sortUsingComparator:^NSComparisonResult(PsdControlModel *model1, PsdControlModel *model2) {
            return model1.layoutModel.top > model2.layoutModel.top;
        }];
        // 遍历行数组，计算它们的y值或垂直居中
        for (NSInteger i = 0; i < rowArray.count - 1; i++) {
            relativeModel = rowArray[i];
            for (NSInteger j = i + 1; j < rowArray.count; j++) {
                PsdControlModel *compareModel = rowArray[j];
                if ([compareModel.originName isEqualToString:@"icon_hotimg"]) {
                    NSLog(@"");
                }
                // 已经有相对的模型布局就不要继续计算了
                if (compareModel.layoutModel.isVerticalInSuper
                    || compareModel.layoutModel.alignVerticalModel
                    || compareModel.layoutModel.alignTopModel
                    || compareModel.layoutModel.alignBottomModel) {
                    continue;
                }
                if ([compareModel.superModel.originName isEqualToString:@"列表2cell"]) {
                    NSLog(@"");
                }
                if (fabs(compareModel.layoutModel.centerY - compareModel.superModel.layoutModel.height * 0.5) <= 1.0) {
                    compareModel.layoutModel.isVerticalInSuper = YES;
                } else if (fabs(compareModel.layoutModel.centerY - relativeModel.layoutModel.centerY) <= 1.0) {
                    // 居中对齐
                    compareModel.layoutModel.alignVerticalModel = relativeModel;
                } else if (fabs(compareModel.layoutModel.top - relativeModel.layoutModel.top) <= 1.0) {
                    // 顶部对齐
                    compareModel.layoutModel.alignTopModel = relativeModel;
                } else if (fabs(compareModel.layoutModel.bottom - relativeModel.layoutModel.bottom) <= 1.0) {
                    // 底部对齐
                    compareModel.layoutModel.alignBottomModel = relativeModel;
                }
            }
        }
    }
}

+ (void)handleColControlLayoutWithSuperModel:(PsdCustomControlModel *)superModel
{
    // 遍历子控件, 排序x，从小到大
    [superModel.subControlModelArray sortUsingComparator:^NSComparisonResult(PsdControlModel *model1, PsdControlModel *model2) {
        return model1.layoutModel.top > model2.layoutModel.top;
    }];
    
    // 计算相对y布局
    PsdControlModel *firstModel = superModel.subControlModelArray.firstObject;
    for (NSInteger i = 1; i < superModel.subControlModelArray.count; i++) {
        PsdControlModel *compareModel = superModel.subControlModelArray[i];
        compareModel.layoutModel.relativeTopModel = firstModel;
        firstModel = compareModel;
    }
    
    // 计算左右对齐
    for (NSInteger i = 1; i < superModel.subControlModelArray.count; i++) {
        PsdControlModel *compareModel = superModel.subControlModelArray[i];
        for (NSInteger j = i - 1; j >= 0; j--) {
            PsdControlModel *relativeModel = superModel.subControlModelArray[j];
            if (fabs(compareModel.layoutModel.centerX - compareModel.superModel.layoutModel.width * 0.5) <= 1.0) {
                // 跟父控件居中
                compareModel.layoutModel.isHorizontalInSuper = YES;
                break;
            } else if (fabs(compareModel.layoutModel.centerX - relativeModel.layoutModel.centerX) <= 1.0) {
                // 居中对齐
                compareModel.layoutModel.alignHorizontalModel = relativeModel;
                break;
            } else if (fabs(relativeModel.layoutModel.left - compareModel.layoutModel.left) <= 1.0) {
                // 左对齐
                compareModel.layoutModel.alignLeftModel = relativeModel;
                break;
            } else if (fabs(compareModel.layoutModel.right - relativeModel.layoutModel.right) <= 1.0) {
                // 右对齐
                compareModel.layoutModel.alignRightModel = relativeModel;
                break;
            }
        }
    }
}

//- (void)handleColControlLayoutWithSuperModel:(PsdCustomControlModel *)superModel
//{
//    // 分配列数组 ： 列数组确定y和对齐的x值
//    NSMutableArray *allColArray = [NSMutableArray array];
//    NSMutableArray *colArray = [NSMutableArray array];
//    [allColArray addObject:colArray];
//    // 遍历子控件, 排序x，从小到大
//    [superModel.subControlModelArray sortUsingComparator:^NSComparisonResult(PsdControlModel *model1, PsdControlModel *model2) {
//        return model1.layoutModel.left > model2.layoutModel.left;
//    }];
//    PsdControlModel *colFirstModel = superModel.subControlModelArray.firstObject;
//    [colArray addObject:colFirstModel];
//    for (NSInteger i = 1; i < superModel.subControlModelArray.count; i++) {
//        PsdControlModel *compareModel = superModel.subControlModelArray[i];
//        // 这里的compareModel的y值肯定比rowFirstModel的y值大，因为已经有过排序
//        if (compareModel.layoutModel.left <= colFirstModel.layoutModel.maxX) {
//            // 同一列, 加入列数组
//            [colArray addObject:compareModel];
//        } else {
//            // 不是同一列，要另起列数组
//            colArray = [NSMutableArray array];
//            colFirstModel = compareModel;
//            [colArray addObject:colFirstModel];
//            [allColArray addObject:colArray];
//        }
//    }
//
//    for (NSMutableArray *colArray in allColArray) {
//        if (colArray.count < 2) {
//            continue;
//        }
//
//        [colArray sortUsingComparator:^NSComparisonResult(PsdControlModel *model1, PsdControlModel *model2) {
//            return model1.layoutModel.top > model2.layoutModel.top;
//        }];
//
//        // 遍历列数组，计算它们的x值或垂直居中
//        for (NSInteger i = 0; i < colArray.count - 1; i++) {
//            PsdControlModel *relativeModel = colArray[i];
//            for (NSInteger j = i + 1; j < colArray.count; j++) {
//                PsdControlModel *compareModel = colArray[j];
//                // 已经有相对的模型布局就不要继续计算了
//                if (compareModel.layoutModel.isHorizontalInSuper
//                    || compareModel.layoutModel.alignHorizontalModel
//                    || compareModel.layoutModel.alignLeftModel
//                    || compareModel.layoutModel.alignRightModel) {
//                    continue;
//                }
//                if (fabs(compareModel.layoutModel.centerX - compareModel.superModel.layoutModel.width * 0.5) <= 1.0) {
//                    compareModel.layoutModel.isHorizontalInSuper = YES;
//                } else if (compareModel.layoutModel.centerX == relativeModel.layoutModel.centerX) {
//                    // 居中对齐
//                    compareModel.layoutModel.alignHorizontalModel = relativeModel;
//                } else if (compareModel.layoutModel.left == relativeModel.layoutModel.left) {
//                    // 顶部对齐
//                    compareModel.layoutModel.alignLeftModel = relativeModel;
//                } else if (compareModel.layoutModel.right == relativeModel.layoutModel.right) {
//                    // 底部对齐
//                    compareModel.layoutModel.alignRightModel = relativeModel;
//                }
//            }
//        }
//
//        // 遍历子控件, 排序x，从小到大
//        [superModel.subControlModelArray sortUsingComparator:^NSComparisonResult(PsdControlModel *model1, PsdControlModel *model2) {
//            return model1.layoutModel.top > model2.layoutModel.top;
//        }];
//
//        // 计算相对布局
//        PsdControlModel *firstModel = superModel.subControlModelArray.firstObject;
//        for (NSInteger i = 1; i < superModel.subControlModelArray.count; i++) {
//            PsdControlModel *compareModel = superModel.subControlModelArray[i];
//            compareModel.layoutModel.relativeTopModel = firstModel;
//            firstModel = compareModel;
//        }
//    }
//}

+ (BOOL)isUseRightLayoutWithModel:(PsdControlModel *)controlModel
{
    if (controlModel.superModel.layoutModel.width > 0) {
        // x值超过父控件的宽度的一半
        return controlModel.layoutModel.left > controlModel.superModel.layoutModel.width * 0.5;
    } else {
        // 父控件没有相对的宽度，说明父控件是根父控件，这时判断附件left距离近还是right距离近就好
        return controlModel.layoutModel.left > controlModel.layoutModel.right;
    }
}
@end
