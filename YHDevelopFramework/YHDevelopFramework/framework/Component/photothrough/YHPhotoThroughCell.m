//
//  YHPhotoThroughCell.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/14.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHPhotoThroughCell.h"

@interface YHPhotoThroughCell ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation YHPhotoThroughCell
#pragma mark - life cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:1.0];
    [self addGesture];
}

#pragma mark - define
- (void)setImage:(UIImage *)image {
    
    _image = image;
    self.imageView.image = image;
    [self.scrollView setZoomScale:1.0f animated:NO];
}
//添加手势
- (void)addGesture {
    //单击手势
    UITapGestureRecognizer *sigleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTapHandle:)];
    [self.contentView addGestureRecognizer:sigleTap];
    //双击手势
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapHandle:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.contentView addGestureRecognizer:doubleTap];
    
    [sigleTap requireGestureRecognizerToFail:doubleTap];
}

#pragma mark - response

- (void)oneTapHandle:(UITapGestureRecognizer *)tap {
    
    if (self.tapGestureHandle) {
        self.tapGestureHandle();
    }
}
- (void)doubleTapHandle:(UITapGestureRecognizer *)tap {
    
    CGPoint point = [tap locationInView:self.imageView];
    if (self.scrollView.zoomScale == 1.0) {
        //放大
        [self.scrollView zoomToRect:CGRectMake(point.x - 50, point.y - 50, 100, 100) animated:YES];
    } else {
        //还原
        [self.scrollView setZoomScale:1.0f animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return self.imageView;
}

@end
