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

@interface ViewController ()<SYSelectTableDelegate>
@property (nonatomic, assign) NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标题";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(UIButton *)sender {
    SYSelectTable *table = [[SYSelectTable alloc] initWithDatas:@[@"学习·1",@"学习·2", @"学习·3"] andDirection:SYSelectBoxArrowPositionTopCenter];
    table.delegate = self;
    [table showDependentOnView:self.navigationController.navigationBar];
}

- (void)sy_didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了%zd",indexPath.row);
}
@end
