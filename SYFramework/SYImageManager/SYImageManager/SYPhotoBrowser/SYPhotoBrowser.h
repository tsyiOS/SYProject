//
//  SYPhotoBrowser.h
//  SYImagePickerDevelop
//
//  Created by leju_esf on 16/12/22.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPhoto.h"
@interface SYPhotoBrowser : UIViewController
@property (nonatomic, strong) UIImageView *sourceImageView;
@property (nonatomic, strong) NSArray <SYPhoto *>*images;
@property (nonatomic, assign) NSInteger currentIndex;
- (void)show;
@end
