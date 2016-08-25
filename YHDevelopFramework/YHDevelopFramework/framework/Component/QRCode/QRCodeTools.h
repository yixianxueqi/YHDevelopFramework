//
//  QRCodeTools.h
//  testQRCode
//
//  Created by 君若见故 on 16/4/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//成功回调
typedef void(^readQRCodeSuccessBlock)(NSString *str);
//失败回调
typedef void(^readQRCodeFailureBlock)(NSString *str);

#ifndef kWindowSize
// 设备主屏大小
#define kWindowSize [UIScreen mainScreen].bounds.size

#endif
/**
 *  QRCode 工具类
 */
@interface QRCodeTools : NSObject

/**
 *  检测摄像头是否可用
 *
 *  @return bool
 */
+ (BOOL)exampleCameraAvailable;
/**
 *  检测是否可访问相册
 *
 *  @return bool
 */
+ (BOOL)examplePhotoLibraryAvailable;
/**
 *  从资源文件读取图片
 *
 *  @param name 名字
 *  @param type leix
 *
 *  @return UIImage
 */
+ (UIImage *)imageByResName:(NSString *)name Type:(NSString *)type;

//指定宽度的等比例压缩
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end
