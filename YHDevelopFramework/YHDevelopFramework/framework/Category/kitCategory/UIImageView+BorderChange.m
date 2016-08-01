//
//  UIImageView+BorderChange.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/18.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "UIImageView+BorderChange.h"

@implementation UIImageView (BorderChange)

//圆形图片
- (void)circleBorder {
  //添加遮罩形成圆形
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    CGFloat width = self.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, width, width)];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    self.layer.mask = shapeLayer;
}
//圆角图片
- (void)cornerBorder:(CGFloat)radius {
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    self.layer.mask = shapeLayer;
    
}

@end
