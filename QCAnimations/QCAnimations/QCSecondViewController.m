//
//  QCSecondViewController.m
//  QCAnimations
//
//  Created by 程庆春 on 2016/10/18.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "QCSecondViewController.h"

#define IMAGE_HEIGHT 150

@interface QCSecondViewController () <CALayerDelegate>
@property (weak, nonatomic) CALayer *layer;
@end

@implementation QCSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"图层绘图";
    CALayer *layer = [[CALayer alloc]init];
    layer.bounds = CGRectMake(0, 0, IMAGE_HEIGHT, IMAGE_HEIGHT);
    layer.position = CGPointMake(160, 200);
    layer.cornerRadius = IMAGE_HEIGHT / 2;
    layer.masksToBounds = YES;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2.0;

    layer.delegate = self;
    [self.view.layer addSublayer:layer];
    [layer setNeedsDisplay];
    self.layer = layer;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.layer.delegate = nil;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -IMAGE_HEIGHT);
    UIImage *image = [UIImage imageNamed:@"IMG_0188"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, IMAGE_HEIGHT, IMAGE_HEIGHT), image.CGImage);
    CGContextRestoreGState(ctx);
}

@end
