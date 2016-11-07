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
#import "CPUImageFilterUtil.h"
#import "UIImage+SYExtension.h"
#import "SYImageRenderViewController.h"

@interface ViewController ()<SYImagePickerDelegate,SYImageEditDelegate>
@property (nonatomic, strong) RTHPictureDisplayView *display;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
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
    SYImageManager *manager = [SYImageManager shareImageManager];
    manager.delegate = self;
    [manager sy_OpenCamera];
}
- (IBAction)album {
    SYImageManager *manager = [SYImageManager shareImageManager];
    manager.delegate = self;
    [manager sy_OpenImagePicker];
}

- (IBAction)editPhoto {
    SYImageEditViewController *editVc = [[SYImageEditViewController alloc] init];
    editVc.image = self.image;
    editVc.delegate = self;
    [self presentViewController:editVc animated:YES completion:nil];
}

- (IBAction)renderPhoto {
    SYImageRenderViewController *renderVC = [[SYImageRenderViewController alloc] init];
    renderVC.image = self.image;
     [self presentViewController:renderVC animated:YES completion:nil];
}

- (void)sy_didFinishedEditingPhoto:(UIImage *)image {
    self.imageView.image = image;
}

- (void)sy_didFinishedPickingMediaWithInfo:(NSDictionary *)info {
//    [self.display dispalyImages:info[SYSelectedImages]];
    NSArray *array  = info[SYSelectedAssets];
    ALAsset *asset = array.firstObject;
   
    self.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//    self.asset = asset;
//    self.imageView.image =  [CPUImageFilterUtil imageWithImage:self.image withColorMatrix:colormatrix_lomo];
    self.imageView.image = [self.image sy_renderByType:SYImageRenderTypeYS];
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
