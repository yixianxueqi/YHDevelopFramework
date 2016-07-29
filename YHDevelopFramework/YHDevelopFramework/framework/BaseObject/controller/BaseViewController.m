//
//  BaseViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册语言变换通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged) name:LanguageChangeNotifiacation object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)dealloc {
    //移除语言通知的监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LanguageChangeNotifiacation object:nil];
}

#pragma mark - define
//展示等待菊花
- (void)showLoading {
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationFade;
    [hud removeFromSuperViewOnHide];
    [hud show:YES];
}
//隐藏等待菊花
- (void)hideLoading {
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
//显示文字提示，默认2s
- (void)showMBProgressHUDWithText:(NSString *)text {

    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.detailsLabelText = text;
    hud.margin = 10.f;
    hud.yOffset = 100.f;
    [hud removeFromSuperViewOnHide];
    [hud hide:YES afterDelay:2.f];
}
//显示文字提示并达到指定时间
- (void)showMBProgressHUDWithText:(NSString *)text duration:(CGFloat)duration {

    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.detailsLabelText = text;
    hud.margin = 10.f;
    hud.yOffset = 100.f;
    [hud removeFromSuperViewOnHide];
    [hud hide:YES afterDelay:duration];
}

#pragma mark - 应用内语言国际化
- (void)languageChanged {
    //子类通过重写此方法，来实现语言转变
}

@end
