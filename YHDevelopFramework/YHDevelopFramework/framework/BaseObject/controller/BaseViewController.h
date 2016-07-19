//
//  BaseViewController.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Masonry.h>
#import "YHLogger.h"
#import "UIView+Frame.h"
#import "NSDate+YHDateFormat.h"
/**
 * @class  BaseViewController
 *
 * @abstract 控制器基类
 *
 */
@interface BaseViewController : UIViewController

//展示等待菊花
- (void)showLoading;
//隐藏等待菊花
- (void)hideLoading;
//显示文字提示，默认2s
- (void)showMBProgressHUDWithText:(NSString *)text;
//显示文字提示并达到指定时间
- (void)showMBProgressHUDWithText:(NSString *)text duration:(CGFloat)duration;

@end
