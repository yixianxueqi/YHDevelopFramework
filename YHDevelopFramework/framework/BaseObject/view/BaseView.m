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

    return [self getBackgroundViewFrame:frame image:[UIImage imageNamed:@"nodata_zore"]];
}
//获取无网络链接图
- (UIView *)getNoNetViewFrame:(CGRect)frame {
    
    return [self getBackgroundViewFrame:frame image:[UIImage imageNamed:@"nodata_error"]];
}
//获取提示图
- (UIView *)getBackgroundViewFrame:(CGRect)frame image:(UIImage *)image {

    UIView *view = [[UIView alloc] initWithFrame:frame];
    UIImageView *igv = [[UIImageView alloc] init];
    igv.image = image;
    igv.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:igv];
    [igv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY).multipliedBy(0.75);
        make.width.equalTo(view.mas_width).multipliedBy(0.75);
        make.height.equalTo(view.mas_width).multipliedBy(0.5);
    }];
    return view;
}

@end
