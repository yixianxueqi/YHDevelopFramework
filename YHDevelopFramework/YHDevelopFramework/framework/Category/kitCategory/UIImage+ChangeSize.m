//
//  UIImage+ChangeSize.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/19.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "UIImage+ChangeSize.h"

@implementation UIImage (ChangeSize)

//按比例压缩图片到指定宽度
- (UIImage *)compressToTargetWidth:(CGFloat)defineWidth {

    UIImage *newImage = nil;
    CGSize imageSize = self.size;
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
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

//img 需要压缩的对象 限制最高数据量KB step每循环一次步进值
- (NSData *)adjustlimitSize:(NSInteger)size step:(float)delta {
    
    NSUInteger dataSize = size * 1000;
    NSData *ImageData = UIImagePNGRepresentation(self);
    float step = 1.0;
    if (ImageData.length > dataSize) {
        while (ImageData.length > dataSize && step > 0) {
            
            ImageData = UIImageJPEGRepresentation(self, step -= delta);
            
            NSLog(@"%lu",(unsigned long)ImageData.length);
        }
    }
    return ImageData;
}

@end
