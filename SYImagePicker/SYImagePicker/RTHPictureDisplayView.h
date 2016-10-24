//
//  RTHPictureDisplayView.h
//  SYImagePicker
//
//  Created by 唐绍禹 on 16/10/25.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTHPictureDisplayView : UIView
@property (nonatomic, copy) void (^addPcitureAction)();
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) NSInteger maxCount;
@end

@interface RTHPictureItem : UIView
@property (nonatomic, copy) void (^deleateItem)();
@property (nonatomic, copy) void (^clickAction)();
- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image isAddBtn:(BOOL)add;
@end