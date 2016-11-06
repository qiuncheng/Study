//
//  ViewController.m
//  BlockBasic
//
//  Created by 程庆春 on 2016/10/28.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//
//  以数据流为导向的数据block

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@property (nonatomic, assign) int result;

- (instancetype) calculate: (int (^)(int)) calculateBack;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Person *p1 = [[Person alloc] init];
    Person *p2 = [[Person alloc] init];
    p1.a = 1;
    p2 = p1;
    p2.a = 2;
    NSLog(@"p1.a = %d, p2.a = %d", p1.a, p2.a);
}

- (instancetype)calculate:(int (^)(int))calculateBack {
    self.result = calculateBack(self.result);
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    int r = [[ViewController new] calculate:^int(int result) {
        result += 10;
        result *= 5;
        return result;
    }].result;
    NSLog(@"%d", r);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
