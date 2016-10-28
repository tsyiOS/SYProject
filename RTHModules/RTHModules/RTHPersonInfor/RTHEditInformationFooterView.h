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
/**
 *  展示图片的view
 */
@property (nonatomic, strong) RTHPictureDisplayView *displayView;
/**
 *  底部按钮点击事件
 */
@property (nonatomic, copy) void (^bottomBtnAction)();
/**
 *  点击儒思协议事件
 */
@property (nonatomic, copy) void (^optionalBtnAction)();
/**
 *  同意按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
/**
 *  “请上传照片”提示Label
 */
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
/**
 *  实例方法
 *
 *  @return 实例对象
 */
+ (instancetype)viewFromNib;
@end
