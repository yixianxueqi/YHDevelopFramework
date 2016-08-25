//
//  QRCodeTools.m
//  testQRCode
//
//  Created by 君若见故 on 16/4/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "QRCodeTools.h"

@interface QRCodeTools ()

@end

@implementation QRCodeTools

/**
 *  检测摄像头是否可用
 *
 *  @return bool
 */
+ (BOOL)exampleCameraAvailable {

    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
/**
 *  检测是否可访问相册
 *
 *  @return bool
 */
+ (BOOL)examplePhotoLibraryAvailable {

    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}
/**
 *  从资源文件读取图片
 *
 *  @param name 名字
 *  @param type leix
 *
 *  @return UIImage
 */
+ (UIImage *)imageByResName:(NSString *)name Type:(NSString *)type {

    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return [UIImage imageWithContentsOfFile:path];
}

//指定宽度的等比例压缩
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
