//
//  Student+test.m
//  QCTest
//
//  Created by 程庆春 on 2016/10/15.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "Student+test.h"

@implementation Student (test)
+ (void)load {
    NSLog(@"%s", __func__);
}
+ (void)initialize {
    NSLog(@"%s", __func__);
}
@end
