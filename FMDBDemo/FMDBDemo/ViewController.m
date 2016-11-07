//
//  ViewController.m
//  FMDBDemo
//
//  Created by 程庆春 on 06/11/2016.
//  Copyright © 2016 qiuncheng.com. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManager.h"
#import <FMDB/FMDB.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *ageTextFiled;

@property (strong, nonatomic) FMDBManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.manager = [[FMDBManager alloc] init];
    [self.manager createTable];
}
- (IBAction)addButtonClicked:(id)sender {
    NSDate *date = [NSDate date];
//    float fData = [date timeIntervalSince1970];
    NSLog(@"name: %@, \n, age: %@", self.nameTextFiled.text, self.ageTextFiled.text);
//    [self.manager insertDataWithName:self.nameTextFiled.text age:self.ageTextFiled.tex];
    [self.manager insertDataWithName:self.nameTextFiled.text age:self.ageTextFiled.text date:[NSString stringWithFormat:@"%f", [date timeIntervalSince1970]]];
}
- (IBAction)deletedButtonClicked:(id)sender {
//    [self.manager deleteDataWithName:self.nameTextFiled.text];
    [self.manager deleteDataWithName:self.nameTextFiled.text age:self.ageTextFiled.text];
}
- (IBAction)updateButtonClicked:(id)sender {
}
- (IBAction)queryButtonClicked:(id)sender {
    [self.manager queryDataWithName:self.nameTextFiled.text];
//    if ([result next]) {
//        NSLog(@"%@",[result stringForColumn:@"name"]);
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
