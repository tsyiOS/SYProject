//
//  SYScanLifeViewController.m
//  SYScanLife
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYScanLifeViewController.h"

#define SYScanLifeSrcName(file) [@"SYScanLifeSource.bundle" stringByAppendingPathComponent:file]
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScanFrame CGRectMake(50, 65+64, ScreenW - 100, ScreenW - 100)

@interface SYScanLifeViewController ()<UIAlertViewDelegate,AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) UIImageView *scanBackground;
@property (nonatomic, strong) UIImageView *scanLine;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) SYMaskView *maskView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backBtn;
@end

@implementation SYScanLifeViewController

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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
   
    [self.view addSubview: self.maskView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.scanBackground];
    [self.view addSubview:self.scanLine];
    [self.view addSubview:self.tipLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描二维码";
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)startScaning {
    [self.session startRunning];
    [self addAnimationForLine];
}

- (void)stopScaning {
    [ self.session stopRunning];
    [self.scanLine.layer removeAnimationForKey:@"moveAnimation"];
}

- (void)backAction {
    if ([self.navigationController.viewControllers containsObject:self]) {
        [self.navigationController popViewControllerAnimated:NO];
    }else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
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

#pragma mark - 扫描成功后的代理方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection {
    if ([metadataObjects count] > 0 ) {
        [self stopScaning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        NSString *stringValue = metadataObject.stringValue;
        NSLog(@"扫描结果=%@",stringValue);
        if (self.sy_finishedScan) {
            self.sy_finishedScan(stringValue);
        }
        [self backAction];
    }
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
            [[UIApplication sharedApplication] openURL:setUrl];
        }else {
           [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)addAnimationForLine {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(ScreenW*0.5, _scanLine.frame.origin.y)];
    [path addLineToPoint:CGPointMake(ScreenW*0.5,self.scanBackground.frame.origin.y + self.scanBackground.frame.size.height)];
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = path.CGPath;
    moveAnimation.duration = 3.0f;
    moveAnimation.repeatCount = MAXFLOAT;
    [_scanLine.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
}

#pragma mark - 懒加载
- (UIImageView *)scanBackground {
    if (_scanBackground == nil) {
        _scanBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:SYScanLifeSrcName(@"sy_scan_background")]];
        _scanBackground.frame = ScanFrame;
    }
    return _scanBackground;
}

- (UIImageView *)scanLine {
    if (_scanLine == nil) {
        _scanLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:SYScanLifeSrcName(@"sy_scan_line")]];
        _scanLine.frame = CGRectMake(50, 65+64, ScreenW - 100, 1);
    }
    return _scanLine;
}

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
        
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:input]) {
            [_session addInput:input];
        }
        if ([_session canAddOutput:output]) {
            [_session addOutput:output];
        }
        
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        output.rectOfInterest = CGRectMake(129/ScreenH, 50/ScreenW, (ScreenW - 100)/ScreenH, (ScreenW - 100)/ScreenW);
    }
    return _session;
}

- (SYMaskView *)maskView {
    if (_maskView == nil) {
        _maskView = [[SYMaskView alloc] initWithFrame:self.view.frame];
        _maskView.backgroundColor = [UIColor clearColor];
    }
    return _maskView;
}

- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scanBackground.frame.size.height + self.scanBackground.frame.origin.y, ScreenW, 50)];
        _tipLabel.text = @"将二维码放入框内，即可自动扫描";
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, ScreenW, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"扫描二维码";
    }
    return _titleLabel;
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

@end

#pragma mark - SYMaskView

@implementation SYMaskView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0, 0, 0, .5);
    CGContextFillRect(ctx, self.bounds);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextClearRect(ctx, ScanFrame);
}

@end