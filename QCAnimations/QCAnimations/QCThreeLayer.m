//
//  QCThreeLayer.m
//  QCAnimations
//
//  Created by 程庆春 on 2016/10/21.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "QCThreeLayer.h"

@implementation QCThreeLayer

- (void)drawInContext:(CGContextRef)ctx {
    CGContextSetRGBFillColor(ctx, 0.5, 0.5, 0.5, 1);
    CGContextSetRGBStrokeColor(ctx, 1.0, 0, 0, 1.0);

    CGContextMoveToPoint(ctx, 94, 33);
    CGContextAddLineToPoint(ctx,104.02, 47.39);
    CGContextAddLineToPoint(ctx,120.18, 52.16);
    CGContextAddLineToPoint(ctx,109.91, 65.51);
    CGContextAddLineToPoint(ctx,110.37, 82.34);
    CGContextAddLineToPoint(ctx,94.5, 76.7);
    CGContextAddLineToPoint(ctx,78.63, 82.34);
    CGContextAddLineToPoint(ctx,79.09, 65.51);
    CGContextAddLineToPoint(ctx,68.82, 52.16);
    CGContextAddLineToPoint(ctx,84.98, 47.39);
    CGContextClosePath(ctx);

    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
