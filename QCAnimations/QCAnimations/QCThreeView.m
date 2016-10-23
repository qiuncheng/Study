//
//  QCThreeView.m
//  QCAnimations
//
//  Created by 程庆春 on 2016/10/21.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "QCThreeView.h"
#import "QCThreeLayer.h"

@implementation QCThreeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        QCThreeLayer *layer = [QCThreeLayer layer];
        layer.bounds = CGRectMake(0, 0, 185, 185);
        layer.position = CGPointMake(160, 284);
        layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.5 alpha:1.0].CGColor;
        [layer setNeedsDisplay];

        [self.layer addSublayer:layer];
    }
    return self;
}

@end
