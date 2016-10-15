//
//  QCSingletonClassWith.m
//  Singleton
//
//  Created by 程庆春 on 2016/10/15.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "QCSingletonClassWithSynchronized.h"

@implementation QCSingletonClassWithSynchronized

static id _instance = nil;

+ (instancetype)sharedInstance {
    if (_instance == nil) {
        @synchronized (self) {
            _instance = [[super alloc]init];
        }
    }
    return _instance;
}

+(id) allocWithZone:(struct _NSZone *)zone {
    if (_instance == nil ) {
        @synchronized (self) {
            _instance = [super allocWithZone: zone];
        }
    }
    return _instance;
}

@end
