//
//  ViewController.m
//  QCActionView
//
//  Created by 程庆春 on 2016/10/31.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "QCActionViewTransition.h"

@interface ViewController ()

@property (nonatomic, weak) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Transition" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(switchToNewViewController) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    [self.view addSubview:button];
    button.center = self.view.center;
}
- (void) switchToNewViewController {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    QCActionViewTransition *transiton = [[QCActionViewTransition alloc]initWithViewController:secondVC];
    secondVC.transitioningDelegate = transiton;
    [self presentViewController:secondVC animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
