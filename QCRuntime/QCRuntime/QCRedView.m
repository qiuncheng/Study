//
//  QCRedView.m
//  QCRuntime
//
//  Created by 程庆春 on 2016/10/15.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//


/**
    在这里测试了下 黑魔法
 */
#import "QCRedView.h"
#import <objc/runtime.h>

@implementation QCRedView

+ (void)initialize {

}

+(void)load {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self setUserInteractionEnabled:YES];
        Class class = [self class];
        [self exchangeImplementationsWithClass:class selectorOne:@selector(touchesBegan:withEvent:) selectorTwo:@selector(qc_touchesBegan:withEvent:)];
        [self exchangeImplementationsWithClass:class selectorOne:@selector(touchesMoved:withEvent:) selectorTwo:@selector(qc_touchesMoved:withEvent:)];
        [self exchangeImplementationsWithClass:class selectorOne:@selector(touchesCancelled:withEvent:) selectorTwo:@selector(qc_touchesCancelled:withEvent:)];
        [self exchangeImplementationsWithClass:class selectorOne:@selector(qc_touchesEnded:withEvent:) selectorTwo:@selector(touchesEnded:withEvent:)];
    }
    return self;
}

- (void)qc_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@" -- %s --", __func__);
    [self qc_touchesBegan:touches withEvent:event];
}
- (void)qc_touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-- %s --", __func__);
}
- (void)qc_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-- %s --", __func__);
}
-(void)qc_touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-- %s --", __func__);
}

- (void) exchangeImplementationsWithClass:(Class)class selectorOne:(SEL)one selectorTwo:(SEL)two {
    Method m1 = class_getInstanceMethod(class, one);
    Method m2 = class_getInstanceMethod(class, two);
    method_exchangeImplementations(m1, m2);
}

@end
