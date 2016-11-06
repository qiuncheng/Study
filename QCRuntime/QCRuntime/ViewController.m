//
//  ViewController.m
//  QCRuntime
//
//  Created by 程庆春 on 2016/10/15.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

/**
    之前不知在哪里看到一篇文章说是touches事件会和gesture冲突，在这里我测试了下，并没有。各个事件并不冲突。
    < 那篇文章里说向view添加了tap事件后tapGesture事件会消失 >
 */
#import "ViewController.h"
#import "QCRedView.h"

@interface ViewController ()

@property (strong, nonatomic) QCRedView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.redView = [[QCRedView alloc]initWithFrame: CGRectMake(100, 100, 200, 200)];
    UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    UISwipeGestureRecognizer *swipGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    [self.redView addGestureRecognizer:tapGeture];
    [self.redView addGestureRecognizer:swipGesture];
    [self.view addSubview:self.redView];

    QCRedView *p1 = [[QCRedView alloc] init];
    QCRedView *p2 = [[QCRedView alloc] init];
    p1.a = 1;
    p2 = p1;
    p2.a = 2;
    NSLog(@"%d, %d", p1.a, p2.a);

}

- (void) tapGesture:(UITapGestureRecognizer*) geture {
    NSLog(@"-%s-", __func__);
}
- (void)swipeGesture:(UISwipeGestureRecognizer*)gesture {
    NSLog(@"-%s-", __func__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
