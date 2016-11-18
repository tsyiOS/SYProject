//
//  ViewController.m
//  SYSelectBox
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYSelectBox.h"
#import "SYSelectTable.h"

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
//    UILabel *label = [[UILabel alloc] init];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"哈哈哈";
//    SYSelectTable *box = [[SYSelectTable alloc] initWithSize:CGSizeMake(300, 400) direction:_count andCustomView:label];
//    [box showDependentOnView:sender];
//    _count += 1;
    SYSelectTable *table = [[SYSelectTable alloc] initWithDatas:@[@"green",@"gray", @"blue",@"purple", @"yellow",@"purple", @"yellow", @"green",@"gray", @"blue",@"purple", @"yellow",@"purple", @"yellow",@"green",@"gray", @"blue",@"purple", @"yellow",@"purple", @"yellow"] andDirection:SYSelectBoxArrowPositionLeftTop];
    [table showDependentOnView:sender];
}

@end
