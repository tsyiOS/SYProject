//
//  ViewController.m
//  SYSelectBox
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYSelectBox.h"

@interface ViewController ()
@property (nonatomic, assign) NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)show:(UIButton *)sender {
    SYSelectBox *box = [[SYSelectBox alloc] initWithSize:CGSizeMake(10, 10) direction:_count andCustomView:nil];
    [box showDependentOn:sender];
    _count += 1;
}

@end
