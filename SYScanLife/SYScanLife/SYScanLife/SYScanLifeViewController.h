//
//  SYScanLifeViewController.h
//  SYScanLife
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, SYScanType) {
    SYScanTypeQRCode,//二维码
    SYScanTypeBarCode,//条形码
    SYScanTypeQRCodeAndBarCode//条形码和二维码
};

@interface SYScanLifeViewController : UIViewController
/**
 *  扫描的结果回调
 */
@property (nonatomic, copy) void(^finishedScan)(NSString *result);
/**
 *  扫描的类型,默认是 SYScanTypeQRCodeAndBarCode 条形码和二维码
 */
@property (nonatomic, assign) SYScanType type;
@end

@interface SYMaskView : UIView

@end
