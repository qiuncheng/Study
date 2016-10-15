//
//  main.m
//  Singleton
//
//  Created by 程庆春 on 2016/10/15.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//  使用@sychronized() 锁的形式来创建单例模式

#import <Foundation/Foundation.h>
#import "QCSingletonClassWithOnce.h"
#import "QCSingletonClassWithSynchronized.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        QCSingletonClassWithOnce *sin1 = [[QCSingletonClassWithOnce alloc]init];

        QCSingletonClassWithOnce *sin2 = [[QCSingletonClassWithOnce alloc]init];

        QCSingletonClassWithOnce *sin3 = [[QCSingletonClassWithOnce alloc]init];
        QCSingletonClassWithOnce *sin4 = [[QCSingletonClassWithOnce alloc]init];

        NSLog(@"QCSingletonClassWithOnce 1 is : %@", sin1);

        NSLog(@"QCSingletonClassWithOnce 2 is : %@", sin2);
        NSLog(@"QCSingletonClassWithOnce 3 is : %@", sin3);
        NSLog(@"QCSingletonClassWithOnce 4 is : %@", sin4);

        NSLog(@"-------------------------------------------------------");

        QCSingletonClassWithSynchronized *sins1 = [[QCSingletonClassWithSynchronized alloc]init];

        QCSingletonClassWithSynchronized *sins2 = [[QCSingletonClassWithSynchronized alloc]init];

        QCSingletonClassWithSynchronized *sins3 = [[QCSingletonClassWithSynchronized alloc]init];
        QCSingletonClassWithSynchronized *sins4 = [[QCSingletonClassWithSynchronized alloc]init];

        NSLog(@"QCSingletonClassWithSynchronized 1 is : %@", sins1);

        NSLog(@"QCSingletonClassWithSynchronized 2 is : %@", sins2);
        NSLog(@"QCSingletonClassWithSynchronized 3 is : %@", sins3);
        NSLog(@"QCSingletonClassWithSynchronized 4 is : %@", sins4);
    }
    return 0;
}
