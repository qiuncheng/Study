//
//  ViewController.m
//  AFN-YYCache
//
//  Created by yolo on 2017/1/22.
//  Copyright © 2017年 Qiuncheng. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <YYCache/YYCache.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (strong, nonatomic) YYDiskCache *diskCache;

@end

@implementation ViewController

static NSString * const urlStr = @"http://gank.io/api/day/2017/01/22";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.activityIndicatorView startAnimating];
    self.activityIndicatorView.hidesWhenStopped = YES;
    [self fetchData];
    
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *path = [cacheFolder stringByAppendingPathComponent:@"test_yy_cache"];
    
    self.diskCache = [[YYDiskCache alloc] initWithPath:path];
    // [YYCache cacheWithName:@"test_yy_cache"];
   
}

- (IBAction)reloadData:(id)sender {
    [self fetchData];
}

- (void)fetchData {
    NSDate *current = [NSDate date];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id data = [self.diskCache objectForKey:urlStr];
        NSLog(@"Global 1 ----%@", [NSThread currentThread]);
        if (data) {
            NSString *str = [NSString stringWithFormat:@"%@", data];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Main 1 ----%@", [NSThread currentThread]);
                [_textView setText:str];
            });
        }
    });
    
    [[AFHTTPSessionManager manager] GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.activityIndicatorView stopAnimating];
        NSString *str = [NSString stringWithFormat:@"%@", responseObject];
        [_textView setText:str];
        NSLog(@"Main 2 ----%@", [NSThread currentThread]);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"Global 2 ----%@", [NSThread currentThread]);
            [self.diskCache setObject:responseObject forKey:urlStr];
            NSLog(@"time internal is : %f", -current.timeIntervalSinceNow);
        });
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"----faild");
            [self.activityIndicatorView stopAnimating];
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
