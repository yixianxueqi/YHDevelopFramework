//
//  BaseView.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "YHLogger.h"
#import "UIView+Frame.h"
#import "NSDate+YHDateFormat.h"
#import "YHTools.h"
#import "YHPreConstant.h"
/**
 * @class BaseView
 *
 * @abstract 视图基类
 *
 */
@interface BaseView : UIView

//获取无数据图
- (UIView *)getNoDataViewFrame:(CGRect)frame;
//获取无网络链接图
- (UIView *)getNoNetViewFrame:(CGRect)frame;

@end
