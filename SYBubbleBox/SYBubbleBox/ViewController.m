//
//  ViewController.m
//  SYBubbleBox
//
//  Created by leju_esf on 16/11/2.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYBubbleBox.h"

@interface ViewController ()
@property (nonatomic, strong) SYBubbleBox *bubbleBox;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bubbleBox];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SYBubbleBox *)bubbleBox {
    if (_bubbleBox == nil) {
        _bubbleBox = [[SYBubbleBox alloc] initWithTitles:@[@"打卡",@"地图",@"日常",@"地图",@"日常"] andFrame:CGRectMake(130, 300, 60, 60)];
        _bubbleBox.startAngle = 0;
        _bubbleBox.centerColor = [UIColor purpleColor];
        _bubbleBox.itemColor = [UIColor lightGrayColor];
        _bubbleBox.allowRotation = YES;
        _bubbleBox.centerRotateAngle = 30;
    }
    return _bubbleBox;
}

@end
