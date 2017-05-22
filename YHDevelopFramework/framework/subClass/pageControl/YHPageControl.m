//
//  YHPageControl.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/13.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHPageControl.h"

@interface YHPageControl ()

@property (nonatomic,strong) UIImage *activeImage;
@property (nonatomic,strong) UIImage *inactiveImage;
@property (nonatomic) CGSize pointSize;

@end

@implementation YHPageControl

#pragma mark - life cycle

- (void)setCurrentPage:(NSInteger)currentPage {

    [super setCurrentPage:currentPage];
    [self updateDots];
}

#pragma mark - define

- (void)setPointSize:(CGSize)size {

    _pointSize = CGSizeMake(size.width,size.height);
}

- (void)setActiveImage:(UIImage *)activeImage inactiveImage:(UIImage *)inactiveImage {

    self.activeImage = activeImage;
    self.inactiveImage = inactiveImage;
}
#pragma mark - private

- (void)updateDots {

    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        CGPoint point = dot.frame.origin;
        dot.frame = CGRectMake(point.x, point.y, self.pointSize.width, self.pointSize.height);
        if (i == self.currentPage) {
            if (self.activeImage) {
                dot.image = self.activeImage;
            } else {
                dot.backgroundColor = self.currentPageIndicatorTintColor;
                dot.layer.cornerRadius = self.pointSize.width/2;
            }
        } else {
            if (self.inactiveImage) {
                dot.image = self.inactiveImage;                
            } else {
                dot.backgroundColor = self.pageIndicatorTintColor;
                dot.layer.cornerRadius = self.pointSize.width/2;
            }
        }
    }
}

@end
