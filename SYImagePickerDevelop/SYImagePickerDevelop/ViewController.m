//
//  ViewController.m
//  SYImagePickerDevelop
//
//  Created by leju_esf on 16/10/27.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "RTHPictureDisplayView.h"

@interface ViewController ()
@property (nonatomic, strong) RTHPictureDisplayView *display;
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

- (IBAction)camera {
    
}
- (IBAction)album {
    
}

- (RTHPictureDisplayView *)display {
    if (_display == nil) {
        _display = [[RTHPictureDisplayView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 0) andType:RTHPictuerDisplayTypeEdit];
//        _display.maxCount = LONG_MAX;
        
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
