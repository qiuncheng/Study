//
//  UIView+VS.m
//  SearchBar
//
//  Created by vsccw on 2017/4/14.
//  Copyright © 2017年 Qiun Cheng. All rights reserved.
//

#import "UIView+VS.h"

@implementation UIView(VS)

+ (instancetype)vs_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)ContainerClass {
    return [self appearanceWhenContainedIn:ContainerClass, nil];
}

@end
