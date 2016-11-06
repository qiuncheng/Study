//
//  QCActionViewTransition.h
//  QCActionView
//
//  Created by 程庆春 on 2016/10/31.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//


@import UIKit;

@interface QCActionViewTransition : NSObject<UIViewControllerTransitioningDelegate>

-(instancetype) initWithViewController:(UIViewController *) viewController;
@end
