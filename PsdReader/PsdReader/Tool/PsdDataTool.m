//
//  PsdDataTool.m
//  PsdReader
//
//  Created by huangkaizhan on 2018/1/15.
//  Copyright © 2018年 huangkaizhan. All rights reserved.
//

#import "PsdDataTool.h"
#import "PsdRootModel.h"
#import "PsdCustomControlModel.h"
#import "PsdDataLayoutTool.h"

@interface PsdDataTool()
/** 所有控件字典*/
@property (nonatomic, strong) NSMutableDictionary *allControlDict;
@end

@implementation PsdDataTool

SingletonM_lib(Tool);

#pragma mark - 懒加载
ArrayM_Create_Two_Psd(customControlArray, _customControlArray);
ObjectCreate_Psd(NSMutableDictionary, customControlDict, _customControlDict);
ObjectCreate_Psd(NSMutableDictionary, subControlDict, _subControlDict);
ObjectCreate_Psd(NSMutableDictionary, allControlDict, _allControlDict);
ObjectCreate_Psd(NSMutableArray, existFileStringArray, _existFileStringArray);

// 根据json初始化
- (void)setupWithJsonDict:(id)dict
{
    // 释放资源
    for (NSString *key in _allControlDict.allKeys) {
        PsdControlModel *model = _allControlDict[key];
        // 手动释放
        [model handRelease];
    }
    // 移除旧的数据
    [_allControlDict removeAllObjects];
    [_customControlArray removeAllObjects];
    [_customControlDict removeAllObjects];
    [_subControlDict removeAllObjects];
    
    _dataModel = [PsdRootModel objectWithKeyValues:dict];
    [self handleDataWithDataModel:_dataModel];
    // 添加所有的控件集合
    for (NSString *key in self.customControlDict.allKeys) {
        [self.allControlDict setObject:self.customControlDict[key] forKey:key];
    }
    for (NSString *key in self.subControlDict.allKeys) {
        [self.allControlDict setObject:self.subControlDict[key] forKey:key];
    }
    
    // 处理控件布局
    [PsdDataLayoutTool handleSubControlLayoutWithSuperControlArray:self.customControlArray];
    
    // 处理默认名
    [self handleDefaultValName];
//    PsdCustomControlModel *testModel = nil;
//    for (PsdCustomControlModel *superModel in self.customControlArray) {
//        if ([superModel.originName isEqualToString:@"今日热议cell"]) {
//            testModel = superModel;
//        }
//    }
}

// 处理默认名
- (void)handleDefaultValName
{
    for (PsdCustomControlModel *superModel in self.customControlArray) {
        if (!superModel.subControlModelArray.count) {
            continue;
        }

        // 遍历子控件, 排序x，从小到大
        [superModel.subControlModelArray sortUsingComparator:^NSComparisonResult(PsdControlModel *model1, PsdControlModel *model2) {
            if (model1.layoutModel.top == model2.layoutModel.top) {
                return model1.layoutModel.left < model1.layoutModel.left;
            }
            return model1.layoutModel.top > model2.layoutModel.top;
            
        }];

        NSInteger index = 0;
        for (NSInteger i = 0; i < superModel.subControlModelArray.count; i++) {
            if (index >= superModel.labelNameArrayM.count) {
                break;
            }
            PsdControlModel *controlModel = superModel.subControlModelArray[i];
            if (controlModel.controlType == PsdControlTypeLabel) {
                controlModel.isUserDefaultName = YES;
                controlModel.controlVarName = superModel.labelNameArrayM[index++];
            }
        }
    }
}

- (PsdControlModel *)subControlModelWithChildModel:(PsdChildModel *)childModel
{
    NSString *key = [NSString stringWithFormat:@"%@_%@",childModel.rootChildModel.name, childModel.name];
    return self.subControlDict[key];
}

- (PsdControlModel *)controlModelWithChildModel:(PsdChildModel *)childModel
{
    if (childModel.isLayer) {
        return [self subControlModelWithChildModel:childModel];
    } else {
        return self.customControlDict[childModel.name];
    }
}

/**
 处理数据
 
 @param dataModel 源数据模型
 */
- (void)handleDataWithDataModel:(PsdRootModel *)dataModel
{
    for (PsdChildModel *rootModel in dataModel.children) {
        if (!rootModel.isLayer) {
            // 根节点
            rootModel.isRootModel = YES;
            // 调整下frame
            [self adjustFrameWithRootChildModel:rootModel];
        } else {
            // 创建控件模型
            PsdControlModel *controlModel = [self createControlModel:rootModel superModel:nil];
            if (controlModel.controlType != PsdControlTypeNone) {
                // 添加到控件字典
                [self.subControlDict setObject:controlModel forKey:rootModel.name];
            }
        }
        // 修正父节点的frame，根据bg算
        [self changeGroupChildModelFrameByBg:rootModel];
        
        // 设置每一个子子孙孙的根节点
        [self handleRootChildModel:rootModel childModel:rootModel];
        
        // 每一个根节点都当作是自定义控件
        PsdCustomControlModel *customControlModel = [self createCustomControlModel:rootModel superModel:nil];
        
        // 添加自定义控件到数组和字典
        [self.customControlArray addObject:customControlModel];
        [self.customControlDict setObject:customControlModel forKey:rootModel.name];
        
        // 遍历所有子节点，抽取自定义节点，添加子控件模型到父控件模型
        [self addSubControlToSuperControlModel:customControlModel dataModel:rootModel];
    }
}

- (void)adjustFrameWithRootChildModel:(PsdChildModel *)rootChildModel
{
    rootChildModel.left = rootChildModel.left < 0 ? 0 : rootChildModel.left;
    if (rootChildModel.width != 750) {
        rootChildModel.width = 750;
    }
}

// 修正根节点的frame
- (void)changeGroupChildModelFrameByBg:(PsdChildModel *)groupModel
{
    // 倒序，bg通常再最后一个
    for (NSInteger i = groupModel.children.count - 1; i >= 0; i--) {
        PsdChildModel *childModel = groupModel.children[i];
        if (!childModel.isLayer) {
            [self changeGroupChildModelFrameByBg:childModel];
        }
        // 判断背景，重置根节点的frame
        if ([childModel.name containsString:@"bg"]) {
            if (childModel.isRootModel) {
                [self adjustFrameWithRootChildModel:childModel];
            }
            groupModel.top = childModel.top;
            groupModel.left = childModel.left;
            groupModel.right = childModel.right;
            groupModel.bottom = childModel.bottom;
            groupModel.width = childModel.width;
            groupModel.height = childModel.height;
        }
    }
}

// 设置每一个根节点
- (void)handleRootChildModel:(PsdChildModel *)rootChildModel childModel:(PsdChildModel *)childModel
{
    for (PsdChildModel *model in childModel.children) {
        [self handleRootChildModel:rootChildModel childModel:model];
        model.rootChildModel = rootChildModel;
    }
}

// 添加子控件模型到父控件模型
- (void)addSubControlToSuperControlModel:(PsdCustomControlModel *)superControlModel dataModel:(PsdChildModel *)dataModel
{
    for (PsdChildModel *model in dataModel.children) {
        // 不可见，下一个
        if (!model.visible) {
            continue;
        }
        // 层组不同处理，层不可能是自定义控件，组才有可能，但有规范
        if (model.isLayer) {
            // 创建控件模型
            PsdControlModel *controlModel = [self createControlModel:model superModel:superControlModel];
            // 判断是否是正常的控件,如果是，那么把它加到父控件模型的数组中
            if (controlModel.controlType != PsdControlTypeNone) {
                [superControlModel.subControlModelArray addObject:controlModel];
                // 添加到控件字典
                [self.subControlDict setObject:controlModel forKey:[NSString stringWithFormat:@"%@_%@",model.rootChildModel.name,model.name]];
            }
        } else {
            // 创建自定义控件模型
            PsdCustomControlModel *customControlModel = [self createCustomControlModel:model superModel:superControlModel];
            if (customControlModel.controlType == PsdControlTypeButton) {
                PsdControlModel *controlModel = [self createControlModel:model superModel:superControlModel];
                // 如果是按钮，那么不要把它归为父控件
                [self handleButtonModelWithControlModel:controlModel dataModel:model];
                // 添加子控件
                [superControlModel.subControlModelArray addObject:controlModel];
                // 添加到控件字典
                [self.subControlDict setObject:controlModel forKey:[NSString stringWithFormat:@"%@_%@",model.rootChildModel.name,model.name]];
            } else {
                // 判断它是不是真的自定义 -> 如果这个自定义控件有继承名称
                if (customControlModel.superControlName.length) {
                    // 加入数组和字典
                    [superControlModel.subControlModelArray addObject:customControlModel];
                    [self.customControlArray addObject:customControlModel];
                    [self.customControlDict setObject:customControlModel forKey:model.name];
                    // 因为它是自定义控件，需要递归它的子控件
                    [self addSubControlToSuperControlModel:customControlModel dataModel:model];
                } else {
                    // 2.不是自定义控件，但是有可能有子控件
                    [self addSubControlToSuperControlModel:superControlModel dataModel:model];
                }
            }
        }
    }
}

// 处理按钮格式
- (void)handleButtonModelWithControlModel:(PsdControlModel *)buttonModel dataModel:(PsdChildModel *)dataModel
{
    for (PsdChildModel *childModel in dataModel.children) {
        // 创建控件模型
        PsdControlModel *controlModel = [self createControlModel:childModel superModel:nil];
        if (controlModel.controlType == PsdControlTypeLabel) {
            // 文字
            buttonModel.text = controlModel.text;
            break;
        }
    }
}

// 创建自定义控件模型
- (PsdCustomControlModel *)createCustomControlModel:(PsdChildModel *)model superModel:(PsdCustomControlModel *)superModel
{
    if ([superModel.originName isEqualToString:@"弹窗2view"]) {
        NSLog(@"");
    }
    // 每一个根节点都当作是自定义控件
    PsdCustomControlModel *customControlModel = [[PsdCustomControlModel alloc] initWithChildModel:model];
    customControlModel.superModel = superModel;
    model.translateCompletionBlock = ^(id object) {
        customControlModel.translateName = object;
    };
    return customControlModel;
}

// 创建控件模型
- (PsdControlModel *)createControlModel:(PsdChildModel *)model superModel:(PsdCustomControlModel *)superModel
{
    PsdControlModel *controlModel = [[PsdControlModel alloc] initWithChildModel:model];
    controlModel.superModel = superModel;
    model.translateCompletionBlock = ^(id object) {
        controlModel.translateName = object;
    };
    return controlModel;
}
@end
