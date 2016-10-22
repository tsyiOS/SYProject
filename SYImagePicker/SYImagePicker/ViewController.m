//
//  ViewController.m
//  SYImagePicker
//
//  Created by leju_esf on 16/10/21.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYImagePickerViewController.h"
@interface ViewController ()<SYImagePickerControllerDelegate>

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
- (IBAction)imagePicker {
    SYImagePickerViewController *imagePicker = [[SYImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)sy_didFinishedPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"%@",info);
}

@end
