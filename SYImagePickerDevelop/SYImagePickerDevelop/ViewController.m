//
//  ViewController.m
//  SYImagePickerDevelop
//
//  Created by leju_esf on 16/10/27.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "RTHPictureDisplayView.h"
#import "SYImageManager.h"
#import "SYImageEditViewController.h"

@interface ViewController ()<SYImagePickerDelegate>
@property (nonatomic, strong) RTHPictureDisplayView *display;
@property (nonatomic, strong) UIImage *image;
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
//    SYImageManager *manager = [SYImageManager shareImageManager];
//    manager.delegate = self;
//    [manager sy_OpenCamera];
    SYImageEditViewController *editVc = [[SYImageEditViewController alloc] init];
    editVc.image = self.image;
    [self presentViewController:editVc animated:YES completion:nil];
}
- (IBAction)album {
    SYImageManager *manager = [SYImageManager shareImageManager];
    manager.delegate = self;
    [manager sy_OpenImagePicker];
}

- (void)sy_didFinishedPickingMediaWithInfo:(NSDictionary *)info {
//    [self.display dispalyImages:info[SYSelectedImages]];
    NSArray *array  = info[SYSelectedAssets];
    ALAsset *asset = array.firstObject;
    
    self.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    
}

- (RTHPictureDisplayView *)display {
    if (_display == nil) {
        _display = [[RTHPictureDisplayView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 0) andType:RTHPictuerDisplayTypeEdit];
//        _display.maxCount = LONG_MAX;
        [self.view addSubview:_display];
        
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
