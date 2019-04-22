
//  Singleton_lib.h
//  client
//
//  Created by 黄凯展 on 16-05-25.
//  Copyright (c) 2012年 妈妈网. All rights reserved.
//  单例宏


// .h文件
#define SingletonH_lib(name) + (instancetype)shared##name;

// .m文件
#define SingletonM_lib(name) \
static id _instance; \
 \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
 \
+ (instancetype)shared##name \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
 \
- (id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}
