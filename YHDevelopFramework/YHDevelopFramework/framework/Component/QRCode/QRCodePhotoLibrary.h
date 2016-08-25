//
//  QRCodePhotoLibraryViewController.h
//  testQRCode
//
//  Created by 君若见故 on 16/4/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeTools.h"
/**
 *  从相册读取二维码，支持二维码 >ios7.0
 */
@interface QRCodePhotoLibrary : NSObject

/**
 *  扫描完成回调
 *
 *  @param successBlock 成功回调
 *  @param failureBlock 失败回调
 */
- (void)QRCodeWithImage:(UIImage *)image CompletionSuccess:(readQRCodeSuccessBlock)successBlock Failure:(readQRCodeFailureBlock)failureBlock;

@end
