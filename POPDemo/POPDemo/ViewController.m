//
//  ViewController.m
//  POPDemo
//
//  Created by yolo on 2016/12/24.
//  Copyright © 2016年 Qiuncheng. All rights reserved.
//

#import "ViewController.h"
@import pop;

@interface ViewController () <POPAnimationDelegate>

@property (weak, nonatomic) UIView *animatedView;

@end

@implementation ViewController {
    BOOL _isFirst;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *animatedView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    animatedView.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [animatedView addGestureRecognizer:tap];
    [self.view addSubview:animatedView];
    
    _animatedView = animatedView;
    _isFirst = NO;
}

- (void) handleTap:(UITapGestureRecognizer *)tap {
    _isFirst = !_isFirst;
//    [self.animatedView.layer pop_addAnimation:[self addSpringAnimation] forKey:@"spring"];
//    [self.animatedView.layer pop_addAnimation:[self addBasicAnimation] forKey:@"basic"];
    [self.animatedView.layer pop_addAnimation:[self addDecayAnimation] forKey:@"decay"];
}

- (POPDecayAnimation *) addDecayAnimation {
    POPDecayAnimation *decayAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerSize];
    decayAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(300, 200)];
    decayAnimation.beginTime = CACurrentMediaTime() + 1.0;
    return decayAnimation;
}

- (POPBasicAnimation *) addBasicAnimation {
    POPBasicAnimation *basicAnimation = [POPBasicAnimation easeInAnimation];
    basicAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
    basicAnimation.duration = 0.4;
    if (_isFirst) {
        basicAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(100, 100)];
    }
    else {
        basicAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(200, 200)];
    }
    return basicAnimation;
}

- (POPSpringAnimation *) addSpringAnimation {
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerRotation];
    springAnimation.springBounciness = 20;
    
    if (_isFirst) {
        //        springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(100, 100, 200, 200)];
        //        springAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(200, 200)];
        springAnimation.toValue = @(M_PI / 4);
    } else {
        //        springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(100, 100, 100, 100)];
        //        springAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(100, 100)];
        springAnimation.toValue = @(0);
    }
    springAnimation.name = @"springAnimation";
    return springAnimation;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
