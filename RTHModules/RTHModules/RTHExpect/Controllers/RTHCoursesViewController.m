//
//  RTHCoursesViewController.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/9/19.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHCoursesViewController.h"
#import "RTHIntroductionCell.h"
#import "RTHCoursesCell.h"
#import "RTHTitleCell.h"

@interface RTHCoursesViewController ()

@end

@implementation RTHCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableViewInfromation];
}

- (void)setUpTableViewInfromation {
    [self.tableView sy_registerNibWithClass:[RTHIntroductionCell class]];
    [self.tableView sy_registerNibWithClass:[RTHCoursesCell class]];
    [self.tableView sy_registerNibWithClass:[RTHTitleCell class]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 10;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RTHIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHIntroductionCell class])];
        return cell;
    }else {
        if (indexPath.row == 0) {
            RTHTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHTitleCell class])];
            return cell;
        }else {
            RTHCoursesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHCoursesCell class])];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 190;
    }else {
        if (indexPath.row == 0) {
            return 40;
        }else {
            return 130;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
