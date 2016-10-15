//
//  QCSingletonClass.m
//  Singleton
//
//  Created by 程庆春 on 2016/10/15.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//  利用 dispatch_once 实现单例模式

#import "QCSingletonClassWithOnce.h"

@implementation QCSingletonClassWithOnce

static id _instance = nil;

+ (instancetype)sharedInstance {
    if (_instance == nil ) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[super alloc] init];
        });
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (_instance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [super allocWithZone:zone];
        });
    }
    return _instance;
}

@end
