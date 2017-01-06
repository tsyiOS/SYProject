//
//  SYCardRecognitionManager.m
//  SYIdentityCardRecognition
//
//  Created by leju_esf on 17/1/6.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import "SYCardRecognitionManager.h"
#import <CoreFoundation/CoreFoundation.h>
#import "excards.h"

@interface SYCardRecognitionManager (){
    unsigned char* buffer;
}
@end

@implementation SYCardRecognitionManager
- (instancetype)init {
    if (self = [super init]) {
        const char *thePath = [[[NSBundle mainBundle] resourcePath] UTF8String];
        EXCARDS_Init(thePath);
    }
    return self;
}

- (void)dealloc {
    
}

+ (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image {
    
    CGSize frameSize = CGSizeMake(CGImageGetWidth(image), CGImageGetHeight(image));
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:NO], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:NO], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, frameSize.width,
                                          frameSize.height,  kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, frameSize.width,
                                                 frameSize.height, 8, 4*frameSize.width, rgbColorSpace,
                                                 kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image),
                                           CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}

- (void)recognitionWithCVImageBufferRef:(CVImageBufferRef)imageBuffer complete:(void(^)(SYIdentityModel *model))completion{
   
    if (CVPixelBufferLockBaseAddress(imageBuffer, 0) == kCVReturnSuccess) {
        size_t width= CVPixelBufferGetWidth(imageBuffer);
        size_t height = CVPixelBufferGetHeight(imageBuffer);
        
        CVPlanarPixelBufferInfo_YCbCrBiPlanar *planar = CVPixelBufferGetBaseAddress(imageBuffer);
        size_t offset = NSSwapBigIntToHost(planar->componentInfoY.offset);
        size_t rowBytes = NSSwapBigIntToHost(planar->componentInfoY.rowBytes);
        unsigned char* baseAddress = (unsigned char *)CVPixelBufferGetBaseAddress(imageBuffer);
        unsigned char* pixelAddress = baseAddress + offset;
        
        if (buffer == NULL)
            buffer = (unsigned char*)malloc(sizeof(unsigned char) * width * height);
        
        memcpy(buffer, pixelAddress, sizeof(unsigned char) * width * height);
        
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
        
        unsigned char pResult[1024];
        
        int ret = EXCARDS_RecoIDCardData(buffer, (int)width, (int)height, (int)rowBytes, (int)8, (char*)pResult, sizeof(pResult));
        if (ret > 0) {
            char ctype;
            char content[256];
            int xlen;
            int i = 0;
            ctype = pResult[i++];
            SYIdentityModel *identityModel = [[SYIdentityModel alloc] init];
            identityModel.type = ctype;
            while(i < ret){
                ctype = pResult[i++];
                for(xlen = 0; i < ret; ++i){
                    if(pResult[i] == ' ') { ++i; break; }
                    content[xlen++] = pResult[i];
                }
                content[xlen] = 0;
                if(xlen){
                    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                    if(ctype == 0x21)
                        identityModel.code = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x22)
                        identityModel.name = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x23)
                        identityModel.gender = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x24)
                        identityModel.nation = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x25)
                        identityModel.address = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x26)
                        identityModel.issue = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x27)
                        identityModel.valid = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                }
            }
            
            if ([identityModel gathered]) {
                if (completion) {
                    completion(identityModel);
                }
                buffer = NULL;
            }
        }
    }
}
@end
