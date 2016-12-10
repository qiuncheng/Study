//
//  ViewController.m
//  QCGotoSettingVC
//
//  Created by 程庆春 on 2016/12/3.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tablView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        cell.textLabel.text = @"服务";
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
//        if ([[UIApplication sharedApplication] canOpenURL:[self openUrlWithString:@"Prefs:root=Generral"]]) {
//            [[UIApplication sharedApplication] openURL:[self openUrlWithString:@"Prefs:root=General"]];
//        }
        [[UIApplication sharedApplication] openURL:[self openUrlWithString:@"Prefs:root=WIFI"]];
    }
}
- (NSURL *) openUrlWithString:(NSString *)urlStr {
    return [NSURL URLWithString:urlStr];
}

@end
