//
//  UIImageView+BorderChange.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/18.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @class  UIImageView
 *
 * @abstract 边框处理后的图案
 * @notice 采用遮罩的方式实现
 *
 */
@interface UIImageView (BorderChange)

/**
 *  圆形图片(mak)
 */
- (void)circleBorder;
/**
 *  圆角图片(mask)
 */
- (void)cornerBorder:(CGFloat)radius;

@end
