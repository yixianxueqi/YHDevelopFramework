//
//  BaseView.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()

@end

@implementation BaseView

//获取无数据图
- (UIView *)getNoDataViewFrame:(CGRect)frame {

    UIView *view = [[UIView alloc] initWithFrame:frame];
    UIImageView *igv = [[UIImageView alloc] init];
    __weak typeof(self) weakSelf = self;
    [igv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf).multipliedBy(0.75);
        make.size.equalTo(weakSelf);
    }];
    igv.image = [UIImage imageNamed:@"nodata_zore"];
    igv.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:igv];
    return view;
}
//获取无网络链接图
- (UIView *)getNoNetViewFrame:(CGRect)frame {

    UIView *view = [[UIView alloc] initWithFrame:frame];
    UIImageView *igv = [[UIImageView alloc] init];
    igv.image = [UIImage imageNamed:@"nodata_error"];
    igv.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:igv];
    __weak typeof(self) weakSelf = self;
    [igv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf).multipliedBy(0.75);
        make.size.equalTo(weakSelf);
    }];
    return view;
}

@end
