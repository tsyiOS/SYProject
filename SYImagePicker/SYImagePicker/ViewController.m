//
//  ViewController.m
//  SYImagePicker
//
//  Created by leju_esf on 16/10/21.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
//#import <SYImagePicker/SYImagePickerViewController.h>
#import <SYImageManager/SYImageManager.h>
//#import "SYImageManager.h"
#import "RTHPictureDisplayView.h"
#import <SYCategory/SYCategory.h>

@interface ViewController ()<SYImagePickerDelegate>
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
//    SYImagePickerViewController *imagePicker = [[SYImagePickerViewController alloc] init];
//    imagePicker.delegate = self;
//    
//    [self presentViewController:imagePicker animated:YES completion:nil];
    SYImageManager *manager  = [SYImageManager shareImageManager];
    manager.delegate = self;
    [manager sy_OpenImagePicker];
}
- (IBAction)camera {
    SYImageManager *manager  = [SYImageManager shareImageManager];
    manager.delegate = self;
    [manager sy_OpenCamera];
}

- (void)sy_didFinishedPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"%@",info);
    
    [self.display dispalyImages:info[SYSelectedImages]];
    
}

- (RTHPictureDisplayView *)display {
    if (_display == nil) {
        _display = [[RTHPictureDisplayView alloc] initWithFrame:CGRectMake(0, 20, ScreenW, 0) andType:RTHPictuerDisplayTypeEdit];
        _display.maxCount = LONG_MAX;
        
        [_display setAddPcitureAction:^{
            NSLog(@"添加照片");
        }];
        
        [_display setTakePhotoAction:^{
            NSLog(@"拍照");
        }];
        
        [_display setCancelPhotoAction:^(NSInteger index) {
            NSLog(@"删除照片后把数组中对应的位置的图片删除");
        }];
    }
    return _display;
}

@end
