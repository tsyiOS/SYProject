//
//  SYBrowserViewCell.h
//
//  Created by 唐绍禹 on 15/10/18.
//  Copyright (c) 2015年 tsy. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol SYBrowserViewCellDelegate <NSObject>

@optional
- (void)closeBrowser;

@end

@interface SYBrowserViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak)id <SYBrowserViewCellDelegate>delegate;
@end
