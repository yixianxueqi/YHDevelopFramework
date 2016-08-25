//
//  QRCodeCreateViewController.h
//  testQRCode
//
//  Created by 君若见故 on 16/4/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeTools.h"

//成功回调
typedef void(^createSuccessBlock)(UIImage *image);

/**
 *  生成二维码 >ios7.0
 */
@interface QRCodeCreate: NSObject
//上色
@property (nonatomic,strong) UIColor *onColor;
//背景色
@property (nonatomic,strong) UIColor *offColor;
//二维码大小,如果未设置，则默认大小为300
@property (nonatomic,assign) CGFloat sizeLength;
/**
 *  生成二维码
 *  @param contents     内容
 *  @param successBlock 成功回调
 *  @param failureBlock 失败回调
 */
- (void)QRCodeWithContent:(NSString *)contents CompletionSuccess:(createSuccessBlock)successBlock Failure:(readQRCodeFailureBlock)failureBlock;
/**
 *  生成带中间图片的二维码
 *
 *  @param contents     内容
 *  @param icon         中心logo
 *  @param successBlock 成功回调
 *  @param failureBlock 失败回调
 */
- (void)QRCodeWithContent:(NSString *)contents icon:(UIImage *)icon CompletionSuccess:(createSuccessBlock)successBlock Failure:(readQRCodeFailureBlock)failureBlock;

@end
