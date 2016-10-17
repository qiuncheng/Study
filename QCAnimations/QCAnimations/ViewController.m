//
//  ViewController.m
//  QCAnimations
//
//  Created by 程庆春 on 2016/10/17.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "ViewController.h"

#define WIDTH 50

@interface ViewController ()

@property (weak, nonatomic) CALayer *layer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self drawMyLayer];
}

#pragma mark - Draw Layer
- (void) drawMyLayer {
    CGSize size = [UIScreen mainScreen].bounds.size;

    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:0.7].CGColor;
    layer.position = CGPointMake(size.width / 2, size.height / 2);
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    layer.cornerRadius = WIDTH / 2;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.9;

    [self.view.layer addSublayer:layer];
    self.layer = layer;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
//    CALayer *layer = self.view.layer.sublayers[0];
    CGFloat width = self.layer.bounds.size.width;
    if (width == WIDTH) {
        width = WIDTH * 4;
    } else {
        width = WIDTH;
    }
    self.layer.bounds = CGRectMake(0, 0, width, width);
    self.layer.position = [touch locationInView:self.view];
    self.layer.cornerRadius = width / 2;

}
@end
