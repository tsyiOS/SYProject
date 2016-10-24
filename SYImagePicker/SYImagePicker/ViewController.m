//
//  ViewController.m
//  SYImagePicker
//
//  Created by leju_esf on 16/10/21.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
//#import <SYImagePicker/SYImagePickerViewController.h>
#import "SYImagePickerViewController.h"
#import "RTHPictureDisplayView.h"
#import <SYCategory/SYCategory.h>

@interface ViewController ()<SYImagePickerControllerDelegate>
@property (nonatomic, strong) RTHPictureDisplayView *display;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.display];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)imagePicker {
    SYImagePickerViewController *imagePicker = [[SYImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)sy_didFinishedPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"%@",info);
    self.display.images = info[SYSelectedImages];
    
}

- (RTHPictureDisplayView *)display {
    if (_display == nil) {
        _display = [[RTHPictureDisplayView alloc] initWithFrame:CGRectMake(0, 20, ScreenW, 0)];
        _display.maxCount = 6;
        [_display setAddPcitureAction:^{
            NSLog(@"点击发布");
        }];
    }
    return _display;
}

@end
