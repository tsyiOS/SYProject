//
//  ViewController.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/9/19.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "RTHExpertViewController.h"
#import "RTHCoursesCheckViewController.h"
#import "RTHChatViewController.h"
#import "RTHCircleViewController.h"
#import "RTHPersonViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  专家详情
 */
- (IBAction)pushToExpertVC {
    RTHExpertViewController *expertVC = [[RTHExpertViewController alloc] initWithNibName:@"RTHExpertViewController" bundle:nil];
    [self.navigationController pushViewController:expertVC animated:YES];
}
/**
 *  课程详情
 */
- (IBAction)pushToCoursesDetail {
    RTHCoursesCheckViewController *expertVC = [[RTHCoursesCheckViewController alloc] initWithNibName:@"RTHCoursesCheckViewController" bundle:nil];
    [self.navigationController pushViewController:expertVC animated:YES];
}
/**
 *  聊天
 */
- (IBAction)pushToChatVC {
    RTHChatViewController *expertVC = [[RTHChatViewController alloc] initWithNibName:@"RTHChatViewController" bundle:nil];
    [self.navigationController pushViewController:expertVC animated:YES];
}
/**
 *  圈子
 */
- (IBAction)presentCircleViewController:(id)sender {
    RTHCircleViewController *circleVc = [[RTHCircleViewController alloc] init];
    UINavigationController *circleNav = [[UINavigationController alloc] initWithRootViewController:circleVc];
    [self.navigationController presentViewController:circleNav animated:YES completion:nil];
}
/**
 *  个人
 */
- (IBAction)personPagePush {
    RTHPersonViewController *personVc = [[RTHPersonViewController alloc]initWithNibName:@"RTHPersonViewController" bundle:nil];
    [self.navigationController pushViewController:personVc animated:YES];
}
@end
