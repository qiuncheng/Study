//
//  TransitionAnimator.m
//  QCTransition
//
//  Created by 程庆春 on 23/11/2016.
//  Copyright © 2016 qiuncheng.com. All rights reserved.
//

#import "TransitionAnimator.h"

@implementation TransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];

    UIView *fromView;
    UIView *toView;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    BOOL isPush = [toViewController.navigationController.childViewControllers indexOfObject:toViewController] > [fromViewController.navigationController.childViewControllers indexOfObject:fromViewController];
    fromView.frame = [transitionContext initialFrameForViewController:fromViewController];
    toView.frame = [transitionContext finalFrameForViewController:toViewController];

    [containerView addSubview:toView];

//    if (isPush) {
        NSLog(@"push");

        toView.transform = CGAffineTransformMakeTranslation(0, fromView.frame.size.height);
        [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
//    } else {
//        NSLog(@"pop");
//        fromView.transform = CGAffineTransformMakeTranslation(0, 0);
//        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//            fromView.transform = CGAffineTransformMakeTranslation(0, -toView.frame.size.height);
//        } completion:^(BOOL finished) {
//            [transitionContext completeTransition:YES];
//        }];
//    }
}

@end
