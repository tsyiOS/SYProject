//
//  RTHIntroductViewController.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/9/19.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHIntroductViewController.h"
#import "RTHFriendCircleCell.h"
#import "RTHIntroductionCell.h"
#import "RTHTitleCell.h"

@interface RTHIntroductViewController ()
@property (nonatomic, strong) NSArray *descriptions;
@end

@implementation RTHIntroductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableViewInfromation];
}

- (void)setUpTableViewInfromation {
   
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView sy_registerNibWithClass:[RTHFriendCircleCell class]];
    [self.tableView sy_registerNibWithClass:[RTHIntroductionCell class]];
    [self.tableView sy_registerNibWithClass:[RTHTitleCell class]];
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

#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.descriptions.count+3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RTHIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHIntroductionCell class])];
        cell.topTitleLabel.text = @"专家简介";
        cell.moreDataBtn.hidden = NO;
        return cell;
    }else if (indexPath.row == 1) {
        RTHIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHIntroductionCell class])];
        cell.topTitleLabel.text = @"擅长领域";
        cell.moreDataBtn.hidden = YES;
        return cell;
    }else if (indexPath.row == 2) {
        RTHTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHTitleCell class])];
        cell.topTitleLabel.text = @"圈子动态";
        return cell;

    }else {
        RTHFriendCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHFriendCircleCell class])];
        cell.imageCount = indexPath.row - 3;
        cell.contentLabel.text = self.descriptions[indexPath.row - 3];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (NSArray *)descriptions {
    return @[@"讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确."];
}

@end
