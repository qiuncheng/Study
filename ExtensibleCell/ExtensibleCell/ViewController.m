//
//  ViewController.m
//  ExtensibleCell
//
//  Created by 程庆春 on 2016/10/23.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) UITableViewRowAnimation addRowAnimation;


@end

@implementation ViewController
{
    NSInteger _rowCount;
    NSIndexPath *didSeleIndexPath;
    BOOL indexSelected;
}

NSString * const CellID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _rowCount = 5;
    indexSelected = NO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _rowCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [NSString stringWithFormat:@"cell %zd", indexPath.row];
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);

    NSIndexPath *ip = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    return ip;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexSelected) {
        [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    } else {
        didSeleIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        NSLog(@"%s", __func__);
        [tableView beginUpdates];
        NSMutableArray *indexPaths = [NSMutableArray array];
        _rowCount += 2;
        for (NSInteger i = indexPath.row + 1; i < indexPath.row + 1 + 2; i++) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [indexPaths addObject:ip];
        }
        [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:_addRowAnimation];
        [tableView endUpdates];

        NSMutableArray *updateIndexes = [NSMutableArray array];
        for (NSInteger i = indexPath.row + 3; i < _rowCount; i++) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [updateIndexes addObject:ip];
        }
        [tableView reloadRowsAtIndexPaths:updateIndexes withRowAnimation:_addRowAnimation];
        indexSelected = YES;
    }
}
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
    if (indexSelected) {
        _rowCount -= 2;
        indexSelected = NO;

        [tableView beginUpdates];
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (NSInteger i = indexPath.row + 1; i < indexPath.row + 3; i++) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [indexPaths addObject:ip];
        }
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:_addRowAnimation];
        [tableView endUpdates];

        NSMutableArray *updateIndexes = [NSMutableArray array];
        for (NSInteger i = indexPath.row + 1; i < _rowCount; i++) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [updateIndexes addObject:ip];
        }
        [tableView reloadRowsAtIndexPaths:updateIndexes withRowAnimation:_addRowAnimation];
    }

    NSIndexPath *ip = [NSIndexPath indexPathForRow:indexPath.row inSection: indexPath.section];
    return ip;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"%s", __func__);
}

- (IBAction)removeCell:(id)sender {
    [self.tableView beginUpdates];
    _rowCount -= 2;
    NSIndexPath *indexPath5 = [NSIndexPath indexPathForRow:5 inSection:0];
    NSIndexPath *indexPath6 = [NSIndexPath indexPathForRow:6 inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObjects:indexPath5,indexPath6, nil];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:_addRowAnimation];
    
    [self.tableView endUpdates];
}

- (IBAction)insertNewCell:(id)sender {
    [self.tableView beginUpdates];

    _rowCount += 2;
    NSIndexPath *indexPath5 = [NSIndexPath indexPathForRow:5 inSection:0];
    NSIndexPath *indexPath6 = [NSIndexPath indexPathForRow:6 inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObjects:indexPath5,indexPath6, nil];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:_addRowAnimation];
    [self.tableView endUpdates];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:_addRowAnimation];
}
- (IBAction)addRowAnimationStyle:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            _addRowAnimation = UITableViewRowAnimationLeft;
            break;
        case 1:
            _addRowAnimation = UITableViewRowAnimationRight;
            break;
        case 2:
            _addRowAnimation = UITableViewRowAnimationTop;
            break;
        case 3:
            _addRowAnimation = UITableViewRowAnimationBottom;
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
