//
//  ViewController.m
//  SYPicker
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYPickerTool.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) SYPickerTool *picker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.testLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_picker == nil) {
        _picker = [[SYPickerTool alloc] init];
        _picker.dataSource = @[@"第一行",@"第二行",@"第三行",@"第四行"];
        __weak typeof(self) weakSelf = self;
        [_picker setDoneAction:^(NSInteger index, NSString *string) {
            weakSelf.testLabel.text = string;
        }];
    }
    
     [_picker show];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)testLabel {
    if (_testLabel == nil) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
    }
    return _testLabel;
}

@end
