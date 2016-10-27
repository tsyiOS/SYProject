//
//  RTHCoursesDownLoadViewController.m
//  RTHModules
//
//  Created by leju_esf on 16/10/14.
//  Copyright © 2016年 唐绍禹. All rights reserved.
//

#import "RTHCoursesDownLoadViewController.h"
#import "RTHCourseDownLoadCell.h"
#import "RTHCourseDownLoadTitleCell.h"

@interface RTHCoursesDownLoadViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RTHCoursesDownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView sy_registerNibWithClass:[RTHCourseDownLoadCell class]];
    [self.tableView sy_registerNibWithClass:[RTHCourseDownLoadTitleCell class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  关闭
 */
- (IBAction)closeAction {
    [UIView animateWithDuration:0.25 animations:^{
        self.view.sy_y = ScreenH;
    }];
}
/**
 *  全选
 */
- (IBAction)allSelected {
    
}
/**
 *  下载
 */
- (IBAction)downLoad {
    
}

#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RTHCourseDownLoadTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHCourseDownLoadTitleCell class])];
        return cell;
    }else {
        RTHCourseDownLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHCourseDownLoadCell class])];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 38;
    }else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}


@end
