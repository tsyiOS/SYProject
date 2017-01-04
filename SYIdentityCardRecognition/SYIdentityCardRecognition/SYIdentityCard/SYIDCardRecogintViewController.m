//
//  SYIDCardRecogintViewController.m
//  SYIdentityCardRecognition
//
//  Created by leju_esf on 17/1/4.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import "SYIDCardRecogintViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "excards.h"
#import "SYIdentityModel.h"

#define SYScanLifeSrcName(file) [@"SYScanLifeSource.bundle" stringByAppendingPathComponent:file]
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface SYIDCardRecogintViewController ()<UIAlertViewDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>{
    unsigned char* _buffer;
}
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoDataOutput *output;
@property (nonatomic, strong) NSNumber *outPutSetting;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) SYIdentityModel *identityModel;
@end

@implementation SYIDCardRecogintViewController

- (instancetype)init {
    if (self = [super init]) {
        [self setUpUI];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if ([self isCanOpenCamera]) {
        [self startScaning];
    }
}

- (void)startScaning {
    [self.session startRunning];
//    [self addAnimationForLine];
}

- (void)stopScaning {
    [ self.session stopRunning];
//    [self.scanLine.layer removeAnimationForKey:@"moveAnimation"];
}

- (void)backAction {
    if ([self.navigationController.viewControllers containsObject:self]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)isCanOpenCamera {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (TARGET_IPHONE_SIMULATOR) {
        return NO;
    }else {
        if (status == AVAuthorizationStatusRestricted || status ==AVAuthorizationStatusDenied) {
            return NO;
        }else {
            return YES;
        }
    }
}

- (void)setUpUI {
    if (TARGET_IPHONE_SIMULATOR) {
        [self showErrorWithMessage:@"请使用真机调试!"];
    }else {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusRestricted || status ==AVAuthorizationStatusDenied) {
            NSString *message = [NSString stringWithFormat:@"您没有设置权限访问相机，请去设置->隐私进行设置！"];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            alertView.tag = 1000;
            [alertView show];
        }else {
            [self.view.layer insertSublayer:self.preview atIndex:0];
        }
    }
    [self addVideoInput:AVCaptureDevicePositionBack];
    
    [self.view addSubview:self.backBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showErrorWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    alertView.tag = 999;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 999) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(alertView.tag == 1000){
        if (buttonIndex == 1) {
            NSString *appId = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleIdentifier"];
            NSURL *setUrl = [NSURL URLWithString:[NSString stringWithFormat: @"prefs:root=%@", appId ]];
            NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
            if ([phoneVersion integerValue] >= 10) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }else {
                [[UIApplication sharedApplication] openURL:setUrl];
            }
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - 代理方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
//    NSLog(@"走了而已");
    [self handleResult:sampleBuffer];
}

- (void)handleResult:(CMSampleBufferRef)sampleBuffer {
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    if (CVPixelBufferLockBaseAddress(imageBuffer, 0) == kCVReturnSuccess) {
        size_t width= CVPixelBufferGetWidth(imageBuffer);
        size_t height = CVPixelBufferGetHeight(imageBuffer);
        
        CVPlanarPixelBufferInfo_YCbCrBiPlanar *planar = CVPixelBufferGetBaseAddress(imageBuffer);
        size_t offset = NSSwapBigIntToHost(planar->componentInfoY.offset);
        size_t rowBytes = NSSwapBigIntToHost(planar->componentInfoY.rowBytes);
        unsigned char* baseAddress = (unsigned char *)CVPixelBufferGetBaseAddress(imageBuffer);
        unsigned char* pixelAddress = baseAddress + offset;
       
        if (_buffer == NULL)
            _buffer = (unsigned char*)malloc(sizeof(unsigned char) * width * height);
        
        memcpy(_buffer, pixelAddress, sizeof(unsigned char) * width * height);
        
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
        
        unsigned char pResult[1024];
        
        int ret = EXCARDS_RecoIDCardData(_buffer, (int)width, (int)height, (int)rowBytes, (int)8, (char*)pResult, sizeof(pResult));
        NSLog(@"ret:%d",ret);
        if (ret <= 0) {
            
        }else {

            char ctype;
            char content[256];
            int xlen;
            int i = 0;
            
            ctype = pResult[i++];
            self.identityModel.type = ctype;
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
                        self.identityModel.code = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x22)
                        self.identityModel.name = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x23)
                        self.identityModel.gender = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x24)
                        self.identityModel.nation = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x25)
                        self.identityModel.address = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x26)
                        self.identityModel.issue = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                    else if(ctype == 0x27)
                        self.identityModel.valid = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                }
            }
        
            NSLog(@"====%@",self.identityModel);
            [self stopScaning];
        }
    }

}

- (void)addVideoInput:(AVCaptureDevicePosition)_campos
{
    AVCaptureDevice *videoDevice=nil;
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    if (_campos == AVCaptureDevicePositionBack)
    {
        for (AVCaptureDevice *device in devices)
        {
            if ([device position] == AVCaptureDevicePositionBack)
            {
                if ([device isFocusModeSupported:AVCaptureFocusModeAutoFocus])
                {
                    NSError *error = nil;
                    if ([device lockForConfiguration:&error])
                    {
                        device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
                        [device unlockForConfiguration];
                    }
                }
                videoDevice = device;
            }
        }
    }
    else if (_campos == AVCaptureDevicePositionFront)
    {
        for (AVCaptureDevice *device in devices)
        {
            if ([device position] == AVCaptureDevicePositionFront)
            {
                if ([device isFocusModeSupported:AVCaptureFocusModeAutoFocus])
                {
                    NSError *error = nil;
                    if ([device lockForConfiguration:&error])
                    {
                        device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
                        [device unlockForConfiguration];
                    }
                }
                videoDevice = device;
            }
        }
    }
    else
        NSLog(@"Error setting camera device position.");
}

#pragma mark - 懒加载
- (AVCaptureVideoPreviewLayer *)preview {
    if (_preview == nil) {
        _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _preview.frame = self.view.bounds;
    }
    return _preview;
}

- (AVCaptureSession *)session {
    if (_session == nil) {
        
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:input]) {
            [_session addInput:input];
        }
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
        }
    }
    return _session;
}

- (AVCaptureVideoDataOutput *)output {
    if (_output == nil) {
        _output = [[AVCaptureVideoDataOutput alloc] init];
        _output.videoSettings = [NSDictionary dictionaryWithObject:self.outPutSetting forKey:(id)kCVPixelBufferPixelFormatTypeKey];
        _output.alwaysDiscardsLateVideoFrames = YES;
        dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
        [_output setSampleBufferDelegate:self queue:queue];
    }
    return _output;
}

- (NSNumber *)outPutSetting {
    if (_outPutSetting == nil) {
        _outPutSetting = [NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange];
    }
    return _outPutSetting;
}

- (UIButton *)backBtn {
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 30, 30, 22)];
        [_backBtn setImage:[UIImage imageNamed:SYScanLifeSrcName(@"sy_back")] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    return _backBtn;
}

- (SYIdentityModel *)identityModel {
    if (_identityModel == nil) {
        _identityModel = [[SYIdentityModel alloc] init];
    }
    return _identityModel;
}

- (void)dealloc {
    NSLog(@"消失");
}

@end
