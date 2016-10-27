//
//  ERHEvaluateViewController.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/9/19.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHEvaluateViewController.h"
#import "RTHStudentEvaluateCell.h"

@interface RTHEvaluateViewController ()
@property (nonatomic, strong) NSArray *descriptions;
@end

@implementation RTHEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableViewInfromation];
}

- (void)setUpTableViewInfromation {
    [self.tableView sy_registerNibWithClass:[RTHStudentEvaluateCell class]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
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
    return self.descriptions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTHStudentEvaluateCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHStudentEvaluateCell class])];
    cell.desLabel.text = self.descriptions[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray *)descriptions {
    return @[@"讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.",@"讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确.讲的非常好,守时,表达准确."];
}
@end
