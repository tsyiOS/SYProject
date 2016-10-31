//
//  SYScanLifeViewController.h
//  SYScanLife
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface SYScanLifeViewController : UIViewController
/**
 *  扫描的结果回调
 */
@property (nonatomic, copy) void(^sy_finishedScan)(NSString *url);
@end

@interface SYMaskView : UIView

@end