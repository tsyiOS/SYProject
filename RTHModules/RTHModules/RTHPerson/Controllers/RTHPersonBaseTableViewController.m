//
//  RTHPersonBaseTableViewController.m
//  SYSlideDemo
//
//  Created by yjc on 16/10/12.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHPersonBaseTableViewController.h"

@interface RTHPersonBaseTableViewController ()

@end

@implementation RTHPersonBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(316, 0, 1, 0);
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView sy_observeTableViewContentOffset];
}
@end
