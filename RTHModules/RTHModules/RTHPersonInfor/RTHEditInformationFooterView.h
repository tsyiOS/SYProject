//
//  RTHEditInformationFooterView.h
//  RTHModules
//
//  Created by leju_esf on 16/10/27.
//  Copyright © 2016年 唐绍禹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTHPictureDisplayView.h"

@interface RTHEditInformationFooterView : UIView
@property (nonatomic, strong) RTHPictureDisplayView *displayView;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
+ (instancetype)viewFromNib;
@end
