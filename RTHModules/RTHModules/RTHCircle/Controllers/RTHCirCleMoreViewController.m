//
//  RTHCirCleMoreViewController.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/10/13.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHCirCleMoreViewController.h"
#import "RTHMyCircleCell.h"

@interface RTHCirCleMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *topContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@end

@implementation RTHCirCleMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.tableView sy_registerNibWithClass:[RTHMyCircleCell class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTHMyCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHMyCircleCell class])];
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


@end
