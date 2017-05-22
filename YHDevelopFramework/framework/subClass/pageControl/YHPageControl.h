//
//  YHPageControl.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/13.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * @class  YHPageControl
 *
 * @abstract 自定义pageControl
 *
 */
@interface YHPageControl : UIPageControl

/**
 *  设置圆点大小
 *
 *  @param size CGSize
 */
- (void)setPointSize:(CGSize)size;
/**
 *  设置选中状态图片和非选中状态图片
 *
 *  @param activeImage   选中状态图片
 *  @param inactiveImage 非选中状态图片
 */
- (void)setActiveImage:(UIImage *)activeImage inactiveImage:(UIImage *)inactiveImage;

@end
