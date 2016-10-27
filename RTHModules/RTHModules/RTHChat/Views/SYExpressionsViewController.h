//
//  SYExpressionsViewController.h
//  SYSlideDemo
//
//  Created by leju_esf on 16/10/8.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYExpressionsViewControllerDelegate <NSObject>

@optional
- (void)sy_ExpressionsDidSelectedImage:(UIImage *)image;
- (void)sy_ExpressionsSendMessage;
@end

@interface SYExpressionsViewController : UIViewController
@property(nonatomic,weak)id<SYExpressionsViewControllerDelegate>delegate;
@end
