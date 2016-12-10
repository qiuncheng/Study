//
//  ViewController.m
//  QCTransition
//
//  Created by 程庆春 on 23/11/2016.
//  Copyright © 2016 qiuncheng.com. All rights reserved.
//

#import "ViewController.h"
#import "TransitionAnimator.h"

@interface ViewController () <UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.delegate = self;
//    self.navigationController.navigationBar.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [TransitionAnimator new];
}

@end
