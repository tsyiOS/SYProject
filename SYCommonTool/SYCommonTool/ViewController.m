//
//  ViewController.m
//  SYCommonTool
//
//  Created by leju_esf on 16/11/8.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYCommonTool.h"
#import "SYSwitchView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SYSwitchView *view = [[SYSwitchView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40)];
    view.titles = @[@"列表1",@"长一点文",@"列表2短"];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)tipOne {

    [SYCommonTool sy_showErrorWithMessage:@"提示什么"];
    
}
- (IBAction)tipTwo {
    [SYCommonTool sy_showNoticeWithTitle:@"提示" message:@"打开系统设置" completion:^(UIAlertAction *action){
        [SYCommonTool sy_openAppSystemSetting];
    }];
}
- (IBAction)tipThree {
    [[SYCommonTool shareCommonTool] sy_openPhotoPicker:^(UIImage *image) {
        NSLog(@"%@",NSStringFromCGSize(image.size));
    }];
}

@end
