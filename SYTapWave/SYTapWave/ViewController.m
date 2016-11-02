//
//  ViewController.m
//  SYTapWave
//
//  Created by leju_esf on 16/11/2.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYTapWave.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SYTapWave *wave = [[SYTapWave alloc] initWithFrame:CGRectMake(30, 30, 100, 100)];
    [self.view addSubview:wave];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
