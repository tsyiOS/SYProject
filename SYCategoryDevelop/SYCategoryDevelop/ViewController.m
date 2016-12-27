//
//  ViewController.m
//  SYCategoryDevelop
//
//  Created by leju_esf on 16/10/28.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+SYExtension.h"
#import "UIImage+SYExtension.h"
#import "NSDate+SYExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 200, 200)];
    
    UIImage *image = [UIImage imageNamed:@"d_aini"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:test.frame];
    imageView.image =  [image sy_rotatedByType:SYImageRotationDirectionLeft];
    
    [self.view addSubview:imageView];
    
    NSLog(@"%zd",[[[NSDate date] sy_yesterday] sy_day]) ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
