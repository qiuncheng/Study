//
//  QCActionViewTransition.m
//  QCActionView
//
//  Created by 程庆春 on 2016/10/31.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "QCActionViewTransition.h"

@interface QCActionViewTransition()<UIViewControllerAnimatedTransitioning>

@end

@implementation QCActionViewTransition
//
//- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
//    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
//    if (self) {
//        presentingViewController.modalPresentationStyle = UIModalPresentationCustom;
//    }
//    return self;
//}
- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        viewController.modalPresentationStyle = UIModalPresentationCustom;
//        viewController.transitioningDelegate = self;
    }

    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *presentedViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* presentingViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    NSLog(@"animateTransition");
}


@end
