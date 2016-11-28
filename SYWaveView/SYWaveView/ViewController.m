//
//  ViewController.m
//  SYWaveView
//
//  Created by leju_esf on 16/11/28.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYWaveView.h"

@interface ViewController ()
@property (nonatomic, strong) SYWaveView *wave;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SYWaveView *wave = [[SYWaveView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)*0.5, 100, 200, 200)];
    self.wave = wave;
//    self.wave.valueChangeAnimation = NO;
    [self.view addSubview:wave];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderChange:(UISlider *)sender {
    self.wave.value = sender.value;
}

@end
