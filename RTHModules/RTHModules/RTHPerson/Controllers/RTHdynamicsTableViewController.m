//
//  RTHdynamicsTableViewController.m
//  SYSlideDemo
//
//  Created by yjc on 16/10/12.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHdynamicsTableViewController.h"
#import "RTHdynamicsCell.h"

@interface RTHdynamicsTableViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *descriptions;
@end

@implementation RTHdynamicsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ self setUpTableViewInfromation];
   }

- (void)setUpTableViewInfromation  {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView sy_registerNibWithClass:[RTHdynamicsCell class]];
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.descriptions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTHdynamicsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHdynamicsCell class])];
    
    cell.imageCounts = indexPath.row ;
    cell.contentLbl.text = self.descriptions[indexPath.row];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}- (NSArray *)descriptions {
    return @[@"讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确."];
}

@end
