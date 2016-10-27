//
//  RTHCircleMineViewController.m
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/10/12.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHCircleMineViewController.h"
#import "RTHMyCircleCell.h"
#import "RTHCircleMineHeaderView.h"
#import "RTHCircleTitleView.h"
@interface RTHCircleMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RTHCircleMineHeaderView *headerView;

@end

@implementation RTHCircleMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView sy_registerNibWithClass:[RTHMyCircleCell class]];
    [self.tableView sy_registerNibForSectionHeaderFooterWithClass:[RTHCircleTitleView class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 47;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RTHCircleTitleView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([RTHCircleTitleView class])];
    header.titleLabel.text = section == 0 ? @"我的圈子（10）":@"推荐圈子";
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTHMyCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHMyCircleCell class])];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (RTHCircleMineHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [RTHCircleMineHeaderView headerView];
        _headerView.sy_height = ScreenW/375 * 141;
    }
    return _headerView;
}

@end
