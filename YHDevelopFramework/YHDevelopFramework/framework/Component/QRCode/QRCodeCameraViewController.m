//
//  QRCodeCameraViewController.m
//  testQRCode
//
//  Created by 君若见故 on 16/4/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "QRCodeCameraViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeCameraViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
{
    CGRect scanRect;
    CGSize scanSize;
}
//扫描框
@property (nonatomic, strong) UIView *scanRectView;
//扫描线
@property (nonatomic, strong) UIImageView *lineImageView;
//设备
@property (strong, nonatomic) AVCaptureDevice            *device;
//输入
@property (strong, nonatomic) AVCaptureDeviceInput       *input;
//输出
@property (strong, nonatomic) AVCaptureMetadataOutput    *output;
//会话
@property (strong, nonatomic) AVCaptureSession           *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;

@property (nonatomic,copy) readQRCodeSuccessBlock sucessBlock;
@property (nonatomic,copy) readQRCodeFailureBlock failureBlock;

@end

@implementation QRCodeCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialViewSize];
    [self initialParts];
    
    //添加监听应用进入前后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveLine) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self exampleCondition];
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)QRCodeCompletionSuccess:(readQRCodeSuccessBlock)successBlock Failure:(readQRCodeFailureBlock)failureBlock {

    self.sucessBlock = successBlock;
    self.failureBlock = failureBlock;
}
/**
 *  检验相机权限
 */
- (void)exampleCondition {
    
    if ([QRCodeTools exampleCameraAvailable]) {
        
        [self startRun];
        [self moveLine];
    } else {
        if (self.failureBlock) {
            self.failureBlock(@"无法访问相机");
        }
    }
}

#pragma mark - 业务
//扫描框
- (void)initialViewSize {
    
    scanSize = CGSizeMake(kWindowSize.width*3/4, kWindowSize.width*3/4);
    scanRect = CGRectMake((kWindowSize.width-scanSize.width)/2, (kWindowSize.height-scanSize.height)/2, scanSize.width, scanSize.height);
    scanRect = CGRectMake(0.2, scanRect.origin.x/kWindowSize.width, scanRect.size.height/kWindowSize.height,scanRect.size.width/kWindowSize.width);
}
//初始化组件
- (void)initialParts {
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:([UIScreen mainScreen].bounds.size.height<500)?AVCaptureSessionPreset640x480:AVCaptureSessionPresetHigh];
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    //包含二维码，条形码
    self.output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code];
    self.output.rectOfInterest = scanRect;
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = [UIScreen mainScreen].bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    self.scanRectView = [UIView new];
    [self.view addSubview:self.scanRectView];
    self.scanRectView.frame = CGRectMake(0, 0, scanSize.width, scanSize.height);
    self.scanRectView.center = CGPointMake(self.view.center.x,self.view.bounds.size.height*0.5);
    if (self.scanerBorderColor) {
        self.scanRectView.layer.borderColor = self.scanerBorderColor.CGColor;
    } else {
        self.scanRectView.layer.borderColor = [UIColor redColor].CGColor;
    }
    self.scanRectView.layer.borderWidth = 1;
}

- (void)moveLine {
    
    UIImageView *igv = [self.view viewWithTag:1001];
    [igv removeFromSuperview];
    self.lineImageView = [[UIImageView alloc] init];
    self.lineImageView.tag = 1001;
    [self.view addSubview:self.lineImageView];
    self.lineImageView.contentMode = UIViewContentModeScaleToFill;
    self.lineImageView.image = [QRCodeTools imageByResName:@"QRCodeScanLine" Type:@"png"];
    self.lineImageView.bounds = CGRectMake(0,0, self.scanRectView.bounds.size.width, 8);
    self.lineImageView.center = CGPointMake(self.scanRectView.center.x, self.scanRectView.center.y - self.scanRectView.bounds.size.height*0.5+5);
    [UIView animateKeyframesWithDuration:3 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        
        self.lineImageView.center = CGPointMake(self.scanRectView.center.x, self.scanRectView.center.y + self.scanRectView.bounds.size.height*0.5-5);
    } completion:nil];
}

- (void)startRun {
    [self.session startRunning];
}

- (void)stopRun {
    [self.session stopRunning];
}

//扫描结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects.count == 0) {
        if (self.failureBlock) {
            self.failureBlock(@"无结果");
        }
        return;
    } else if(metadataObjects.count > 0) {
        [self stopRun];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
        if (self.sucessBlock) {
            self.sucessBlock(metadataObject.stringValue);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
