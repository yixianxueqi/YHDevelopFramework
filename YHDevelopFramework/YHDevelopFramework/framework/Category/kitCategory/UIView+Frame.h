//
//  UIView+Frame.h
//
//  Created by 君若见故 on 16/1/25.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

/* 打印frame  */
#define NSLogRect(rect) NSLog(@"%s x:%.2f,y:%.2f,w:%.2f,h:%.2f",#rect,rect.origin.x,rect.origin.y,rect.size.width,rect.size.height)
/* 打印size  */
#define NSLogSize(size) NSLog(@"%s w:%.2f h:%.2f",#size,size.width,size.height)
/* 打印point  */
#define NSLogPoint(point) NSLog(@"%s x:%.2f,y:%.2f",#point,point.x,point.y)

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/**
 *  获得当前屏幕的宽度
 */
+ (CGFloat)screenWidth;
/**
 *  获得当前屏幕的高度
 */
+ (CGFloat)screenHeight;
/**
 *  设置x坐标
 */
- (void)setX:(CGFloat)x;
/**
 *  获取x坐标
 */
- (CGFloat)x;

/**
 *  设置y坐标
 */
- (void)setY:(CGFloat)y;
/**
 *  获取y坐标
 */
- (CGFloat)y;

/**
 *  设置width
 */
- (void)setWidth:(CGFloat)width;
/**
 *  获取width
 */
- (CGFloat)width;

/**
 *  设置height
 */
- (void)setHeight:(CGFloat)height;
/**
 *  获取height
 */
- (CGFloat)height;

/**
 *  设置size
 */
- (void)setSize:(CGSize)size;
/**
 *  获取size
 */
- (CGSize)size;

/**
 *  设置origin
 */
- (void)setOrigin:(CGPoint)origin;
/**
 *  获取origin
 */
- (CGPoint)origin;

/**
 *  获取最大的x
 */
- (CGFloat)maxX;

/**
 *  获取最大的y
 */
- (CGFloat)maxY;
/**
 *  获取最小的x
 */
- (CGFloat)minX;
/**
 *  获取最小的y
 */
- (CGFloat)minY;
/**
 *  获取中间x值
 */
- (CGFloat)midX;
/**
 *  获取中间y值
 */
- (CGFloat)midY;


@end
