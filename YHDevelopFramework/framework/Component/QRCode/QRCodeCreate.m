//
//  QRCodeCreateViewController.m
//  testQRCode
//
//  Created by 君若见故 on 16/4/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "QRCodeCreate.h"

static const double kIconScale = 1 / 6.0;

@interface QRCodeCreate ()

@property (nonatomic,copy) NSString *contents;
@property (nonatomic,copy) createSuccessBlock successBlock;
@property (nonatomic,copy) readQRCodeFailureBlock failureBlock;

@end

@implementation QRCodeCreate


- (void)QRCodeWithContent:(NSString *)contents CompletionSuccess:(createSuccessBlock)successBlock Failure:(readQRCodeFailureBlock)failureBlock {

    self.contents = contents;
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    UIImage *codeImage = [self actionGenerate];
    if (codeImage) {
        if (self.successBlock) {
            self.successBlock(codeImage);
        }
    } else {
        if (self.failureBlock) {
            self.failureBlock(@"无结果");
        }
    }
    
}
- (void)QRCodeWithContent:(NSString *)contents icon:(UIImage *)icon CompletionSuccess:(createSuccessBlock)successBlock Failure:(readQRCodeFailureBlock)failureBlock {
 
    self.contents = contents;
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    UIImage *codeImage = [self actionGenerate];
    codeImage = [self addIcon:icon toImage:codeImage];
    if (codeImage) {
        if (self.successBlock) {
            self.successBlock(codeImage);
        }
    } else {
        if (self.failureBlock) {
            self.failureBlock(@"无结果");
        }
    }
}

- (UIImage *)actionGenerate
{
    NSData *stringData = [self.contents dataUsingEncoding: NSUTF8StringEncoding];
    
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    UIColor *onColor = [UIColor blackColor];
    UIColor *offColor = [UIColor whiteColor];
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:self.onColor?self.onColor.CGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:self.offColor?self.offColor.CGColor:offColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    
    //绘制
    if (self.sizeLength == 0 ) {
        self.sizeLength = 300;
    }
    CGSize size = CGSizeMake(self.sizeLength, self.sizeLength);
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //放大
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    //翻转
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    return codeImage;
}
//添加中心图片
- (UIImage *)addIcon:(UIImage *)icon toImage:(UIImage *)image {

    UIGraphicsBeginImageContext(image.size);
    CGFloat imgW = image.size.width;
    CGFloat imgH = image.size.height;
    CGFloat iconW = imgW * kIconScale;
    CGFloat iconH = imgH * kIconScale;
    [image drawInRect:CGRectMake(0, 0, imgW, imgH)];
    [icon drawInRect:CGRectMake((imgW - iconW)*0.5, (imgH - iconH)*0.5, iconW, iconH)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
