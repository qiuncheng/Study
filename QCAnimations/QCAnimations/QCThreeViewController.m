//
//  QCThreeViewController.m
//  QCAnimations
//
//  Created by 程庆春 on 2016/10/21.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "QCThreeViewController.h"
#import "QCThreeView.h"

@interface QCThreeViewController ()

@end

@implementation QCThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    QCThreeView *tView = [[QCThreeView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:tView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
