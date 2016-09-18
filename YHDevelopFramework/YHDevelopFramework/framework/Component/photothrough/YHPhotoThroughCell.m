//
//  YHPhotoThroughCell.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/14.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHPhotoThroughCell.h"

@interface YHPhotoThroughCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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
}
#pragma mark - response
- (void)oneTap:(UITapGestureRecognizer *)tap {

    NSLog(@"one tap");
    if (self.tapSigleHandleBlock) {
        self.tapSigleHandleBlock();
    }
}

- (void)twoTap:(UITapGestureRecognizer *)tap {
    
    CGPoint point = [tap locationInView:self.imageView];
    NSLog(@"%@",NSStringFromCGPoint(point));
    if (CGAffineTransformIsIdentity(self.imageView.transform) ) {
        CGAffineTransform transform = CGAffineTransformMakeScale(1.3, 1.3);
    } else {
        self.imageView.transform = CGAffineTransformIdentity;
    }
}

- (void)pinchHandle:(UIPinchGestureRecognizer *)pinch {
    
    NSLog(@"pinch");
    NSLog(@"%f,%f",pinch.scale,pinch.velocity);
}

#pragma mark - private
- (void)addGesture {
    
    //添加单击手势
    UITapGestureRecognizer *tapSigle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTap:)];
    [self.imageView addGestureRecognizer:tapSigle];
    //添加双击手势
    UITapGestureRecognizer *tapDouble= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoTap:)];
    tapDouble.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:tapDouble];
    //单击手势识别失败使用双击手势
    [tapSigle requireGestureRecognizerToFail:tapDouble];
    //添加捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchHandle:)];
    [self.imageView addGestureRecognizer:pinch];
}

@end
