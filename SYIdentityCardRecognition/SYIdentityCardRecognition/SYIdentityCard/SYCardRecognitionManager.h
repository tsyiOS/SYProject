//
//  SYCardRecognitionManager.h
//  SYIdentityCardRecognition
//
//  Created by leju_esf on 17/1/6.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SYIdentityModel.h"
#import "SYCoder.h"

@interface SYCardRecognitionManager : NSObject
+ (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image;
- (void)recognitionWithCVImageBufferRef:(CVImageBufferRef)imageBuffer complete:(void(^)(SYIdentityModel *model))completion;
@end
