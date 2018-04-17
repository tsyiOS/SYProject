//
//  ViewController.m
//  SYCommonTool
//
//  Created by leju_esf on 16/11/8.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYCommonTool.h"
#import <UIKit/UIDevice.h>
#import <sys/utsname.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *screenShotImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tipOne {
//    NSString *uuid = [SYCommonTool sy_UUID];
//    BOOL result = [SYCommonTool sy_checkChineseOrEnglishText:@"汉字Eiglish09188"];
//    NSLog(@"%d---%@",result,uuid);
    [SYCommonTool sy_showErrorWithMessage:@"提示什么"];
    
}
- (IBAction)tipTwo {
//    [[SYCommonTool shareCommonTool] sy_openPhotoPicker:^(UIImage *image) {
//        NSLog(@"%@",NSStringFromCGSize(image.size));
//    }];
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
