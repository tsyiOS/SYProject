//
//  RTHCircleDynamicViewController.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/10/12.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHCircleDynamicViewController.h"
#import "RTHCircleStatusCell.h"
#import "RTHCicleDynamicHeaderView.h"

@interface RTHCircleDynamicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *descriptions;
@property (nonatomic, strong) RTHCicleDynamicHeaderView *headerView;
@end

@implementation RTHCircleDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableViewInfromation];
}

- (void)setUpTableViewInfromation {
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView sy_registerNibWithClass:[RTHCircleStatusCell class]];
    __weak typeof(self) weakSelf = self;
    self.tableView.sy_headerRefresh = ^(){
        [weakSelf requestData];
    };
}

#pragma 网络请求
- (void)requestData {
    NSLog(@"请求数据");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView sy_endRefresh];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)publishStatus {
    NSLog(@"发布状态");
}
#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.descriptions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTHCircleStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHCircleStatusCell class])];
    cell.imageCount = indexPath.row;
    cell.contentLabel.text = self.descriptions[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (NSArray *)descriptions {
    return @[@"讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确."];
}

- (RTHCicleDynamicHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [RTHCicleDynamicHeaderView headerView];
    }
    return _headerView;
}

@end
