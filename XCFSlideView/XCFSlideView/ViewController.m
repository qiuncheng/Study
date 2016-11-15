//
//  ViewController.m
//  XCFSlideView
//
//  Created by 程庆春 on 13/11/2016.
//  Copyright © 2016 qiuncheng.com. All rights reserved.
//
//  测试环境： Xcode 8.1 + iPhone 7 Plus Simulator (iOS 10.1) + iOS 10 真机
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *testViewWidthConstraint;
@property (strong, nonatomic) NSMutableArray *imageNames;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewContraintWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewContraintLeading;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;



@property (strong, nonatomic) CALayer *leftLayer;
@property (strong, nonatomic) CALayer *midLayer;
@property (strong, nonatomic) CALayer *rightLayer;

@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;
@property (strong, nonatomic) UIView *midView;

@end


@implementation ViewController {

    /// 用来记录上次停止滚动时的x偏差
    CGFloat lastContentOffsetX;
    /// 用来记录当前在那个界面上
    NSInteger index;

    /// 左中右三个UIImageView
    UIImageView *mImageView;
    UIImageView *lImageView;
    UIImageView *rImageView;

    /// 用来记录scrollView的x和y坐标。注意在storyboard里面设置的时候会出现0的情况
    CGFloat originX;
    CGFloat originY;
}

/// 表示图片的高度和宽度，因为之前在网上下载的缩略图，所以尺寸会比较小。
static CGFloat const scrollViewHeight = 133;
static CGFloat const scrollViewWidth = 200;

#pragma mark - 

- (void)viewDidLoad {
    [super viewDidLoad];

    _scrollView.delegate = self;

    _imageNames = [NSMutableArray array];
    [_imageNames addObject:@"1"];
    [_imageNames addObject:@"2"];
    [_imageNames addObject:@"3"];
    [_imageNames addObject:@"4"];
    [_imageNames addObject:@"5"];
    [_imageNames addObject:@"6"];
    [_imageNames addObject:@"7"];
    [_imageNames addObject:@"8"];
    [_imageNames addObject:@"9"];
    [_imageNames addObject:@"10"];
    [_imageNames addObject:@"11"];

    _scrollView.contentSize = CGSizeMake(scrollViewWidth * _imageNames.count, 0);

    for (int i = 0; i < _imageNames.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(i * scrollViewWidth, 0, scrollViewWidth, scrollViewHeight);
        imageView.image = [UIImage imageNamed:_imageNames[i]];
        [self.scrollView addSubview:imageView];
    }


}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    lastContentOffsetX = 0;
    index = 0;

    [self configViews];

    _testView.clipsToBounds = YES;
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:_imageNames[0]];
    imageView.frame = CGRectMake(-_testView.frame.size.width / 2, 0, _testView.frame.size.width * 2, 128);
    imageView.contentMode = UIViewContentModeCenter;
    [_testView addSubview:imageView];

    originX = _scrollView.frame.origin.x;
    originY = _scrollView.frame.origin.y;

    _indicatorViewContraintWidth.constant = scrollViewWidth / _imageNames.count;


}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat currentContentOffsetX = scrollView.contentOffset.x - lastContentOffsetX;

    if (currentContentOffsetX > 0) { /// 向左滑动
        _midView.frame = CGRectMake(originX, originY, scrollViewWidth - currentContentOffsetX, scrollViewHeight);
        mImageView.frame = CGRectMake(- currentContentOffsetX * 0.5, 0, scrollViewWidth, scrollViewHeight);

        if (rImageView != nil) {
            if (_rightView.hidden == YES) {
                _rightView.hidden = NO;
            }
            _rightView.frame = CGRectMake(originX + scrollViewWidth - currentContentOffsetX, originY, currentContentOffsetX, scrollViewHeight);
            rImageView.frame = CGRectMake(-(100 - currentContentOffsetX * 0.5), 0, scrollViewWidth, scrollViewHeight);
        }

    } else {  /// 向右滑动
        _midView.frame = CGRectMake(originX - currentContentOffsetX, originY, scrollViewWidth + currentContentOffsetX, scrollViewHeight);
        mImageView.frame = CGRectMake(currentContentOffsetX * 0.5, 0, scrollViewWidth, scrollViewHeight);
        if (lImageView != nil) {
            if (_leftView.hidden == YES) {
                _leftView.hidden = NO;
            }
            _leftView.frame = CGRectMake(originX, originY, -currentContentOffsetX, scrollViewHeight);
            lImageView.frame = CGRectMake(-(100 + currentContentOffsetX * 0.5), 0, scrollViewWidth, scrollViewHeight);
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    index = lastContentOffsetX / scrollViewWidth;
    _midView.hidden = NO;
    mImageView = [[UIImageView alloc]init];
    mImageView.image = [UIImage imageNamed:_imageNames[index]];
    [_midView addSubview:mImageView];
    mImageView.contentMode = UIViewContentModeCenter;
    if (index != 0) {
        lImageView = [[UIImageView alloc]init];
        lImageView.contentMode = UIViewContentModeCenter;
        lImageView.image = [UIImage imageNamed:_imageNames[index - 1]];
        [_leftView addSubview:lImageView];
    }
    if (index != _imageNames.count - 1) {
        rImageView = [[UIImageView alloc]init];
        rImageView.contentMode = UIViewContentModeCenter;
        rImageView.image = [UIImage imageNamed:_imageNames[index + 1]];
        [_rightView addSubview:rImageView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    lastContentOffsetX = scrollView.contentOffset.x;
    [_midView.subviews.firstObject removeFromSuperview];
    if (_leftView.subviews.count > 0) {
        [_leftView.subviews.firstObject removeFromSuperview];
    }
    if (_rightView.subviews.count > 0) {
        [_rightView.subviews.firstObject removeFromSuperview];
    }
    _midView.hidden = YES;
    _leftView.hidden = YES;
    _rightView.hidden = YES;

    NSInteger i = lastContentOffsetX / scrollViewWidth;
    _indicatorViewContraintLeading.constant = i * (scrollViewWidth / _imageNames.count);
    _indexLabel.text = [NSString stringWithFormat:@"%zd", i + 1];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark -
#pragma mark private

- (void) configViews {
    _leftView = [[UIView alloc]init];
    _rightView = [[UIView alloc]init];
    _midView = [[UIView alloc]init];

    _leftView.frame = CGRectZero;
    _rightView.frame = CGRectZero;
    _midView.frame = CGRectZero;

    _leftView.contentMode = UIViewContentModeCenter;
    _rightView.contentMode = UIViewContentModeCenter;
    _midView.contentMode = UIViewContentModeCenter;

    _leftView.clipsToBounds = YES;
    _rightView.clipsToBounds = YES;
    _midView.clipsToBounds = YES;

    _leftView.hidden = YES;
    _rightView.hidden = YES;
    _midView.hidden = YES;

    [self.view addSubview:_leftView];
    [self.view addSubview:_rightView];
    [self.view addSubview:_midView];
}

- (IBAction)changeTestViewWidth:(UISlider *)sender {
    _testViewWidthConstraint.constant = sender.value * 150 + 100;
    UIImageView *imageView =  _testView.subviews[0];
    imageView.frame = CGRectMake(-_testView.frame.size.width / 2, 0, _testView.frame.size.width * 2, 128);
}

@end
