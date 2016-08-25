//
//  QRCodePhotoLibraryViewController.m
//  testQRCode
//
//  Created by 君若见故 on 16/4/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "QRCodePhotoLibrary.h"

@interface QRCodePhotoLibrary ()

@property (nonatomic,copy) readQRCodeSuccessBlock sucessBlock;
@property (nonatomic,copy) readQRCodeFailureBlock failureBlock;
@property (nonatomic,copy) UIImage *image;

@end

@implementation QRCodePhotoLibrary

- (void)QRCodeWithImage:(UIImage *)image CompletionSuccess:(readQRCodeSuccessBlock)successBlock Failure:(readQRCodeFailureBlock)failureBlock {

    self.image = image;
    self.sucessBlock = successBlock;
    self.failureBlock = failureBlock;
    [self getContentsFromPhoto];
}

#pragma mark - 业务
//解析
- (void)getContentsFromPhoto {

    __block UIImage *editImage;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        editImage = [QRCodeTools imageCompressForWidth:self.image targetWidth:[UIScreen mainScreen].bounds.size.width];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
        CIImage *image = [CIImage imageWithCGImage:editImage.CGImage];
        NSArray *features = [detector featuresInImage:image];
        //条形码
        if (features.count == 0) {
            detector = [CIDetector detectorOfType:CIDetectorTypeRectangle context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
            features = [detector featuresInImage:image];
        }
        CIQRCodeFeature *feature = [features firstObject];
        NSString *result = feature.messageString;
        if (result) {
            if (self.sucessBlock) {
                self.sucessBlock(result);
            }
        } else {
            if (self.failureBlock) {
                self.failureBlock(@"无结果");
            }
        }
    });

    
}

@end
