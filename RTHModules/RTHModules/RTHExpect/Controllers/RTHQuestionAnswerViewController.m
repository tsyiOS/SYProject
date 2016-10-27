//
//  RTHQuestionAnswerViewController.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/9/19.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHQuestionAnswerViewController.h"

@interface RTHQuestionAnswerViewController ()

@end

@implementation RTHQuestionAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableViewInfromation];
}

- (void)setUpTableViewInfromation {
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
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"问答-%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
