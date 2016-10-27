//
//  RTHReplyPageTableViewController.m
//  SYSlideDemo
//
//  Created by yjc on 16/10/12.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHReplyPageTableViewController.h"

@interface RTHReplyPageTableViewController ()

@end

@implementation RTHReplyPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.sy_headerRefresh = ^(){
        [weakSelf requestData];
    };
    
}
#pragma 网络请求
- (void)requestData {
    NSLog(@"请求数据");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [self.tableView sy_endRefresh];
    });
}

@end
