//
//  ViewController.m
//  SYIdentityCardRecognition
//
//  Created by leju_esf on 17/1/4.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYIDCardRecogintViewController.h"
#import "SYIDListViewController.h"
#import "SYImageManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SYCardRecognitionManager.h"
#import "SYAlertView.h"
#import "SYIdentityModel.h"

@interface ViewController ()<SYImagePickerDelegate>

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

- (void)sy_didFinishedPickingMediaWithInfo:(NSDictionary *)info {
    NSArray *asets = info[SYSelectedAssets];
    ALAsset *asset = asets.firstObject;
//    UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
    
}

- (IBAction)scanIdentityCard:(id)sender {
    SYIDCardRecogintViewController *scanVC = [[SYIDCardRecogintViewController alloc] init];

    [self.navigationController pushViewController:scanVC animated:YES];
}

- (IBAction)recognitIdentityCard {
    [SYImageManager shareImageManager].delegate = self;
    [[SYImageManager shareImageManager] sy_OpenImagePicker];
}
- (IBAction)listVC {
    SYIDListViewController *listvc = [[SYIDListViewController alloc] initWithNibName:NSStringFromClass([SYIDListViewController class]) bundle:nil];
    [self.navigationController pushViewController:listvc animated:YES];
}
@end
