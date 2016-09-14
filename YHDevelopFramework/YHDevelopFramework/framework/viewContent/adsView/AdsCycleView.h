//
//  AdsCycleView.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/13.
//  Copyright © 2016年 isoftstone. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,PageContrlAlignment) {
    
    PageContrlLeftAlignment = 1,
    PageContrlCenterAlignment,
    PageContrlRightAlignment,
};
/**
 * @class  AdsCycleView
 *
 * @abstract 广告轮播视图
 *
 */
@interface AdsCycleView : UIView
//点击回调事件
@property (nonatomic,copy) void(^clickIncidentBlock)(NSInteger index);

/**
 *  设置轮播展示图片和默认图片
 *
 *  @param list  展示图片来源URL
 *  @param image 默认图片
 */
- (void)setImageListWithUrlString:(NSArray<NSString *> *)list placeHoldImage:(UIImage *)image;
/**
 *  设置轮播展示图片
 *
 *  @param list 展示图片来源本地
 */
- (void)setImageList:(NSArray<UIImage *> *)list;

/*
    相关属性设置需要在赋值图片数组前进行
 */

/**
 *  设置图片说明
 *
 *  @param list NSString
 */
- (void)setExplanationOfImageList:(NSArray <NSString *> *)list;
/**
 *  设置pageControl,默认PageContrlRightAlignment
 *
 *  @param pageControl UIPageControl
 *  @param alignment   PageContrlAlignment
 */
- (void)setPageControl:(UIPageControl *)pageControl alignMent:(PageContrlAlignment)alignment;
/**
 *  是否需要文字说明，默认无
 *
 *  @param isNeed BOOL
 */
- (void)isNeedExplanation:(BOOL)isNeed;
/**
 *  是否需要PageControl,默认需要
 *
 *  @param isNeed BOOL
 */
- (void)isNeedPageControl:(BOOL)isNeed;
/**
 *  是否需要自动轮播,默认开启
 *
 *  @param isAuto BOOL
 */
- (void)isAutoCycleShow:(BOOL)isAuto;
/**
 *  自动轮播时间间隔,默认5s
 *
 *  @param seconds CGFloat
 */
- (void)autoCycleSeconds:(CGFloat)seconds;

/*
    定时器相关
 */
- (void)stopTimer;
- (void)resumTimer;

@end
