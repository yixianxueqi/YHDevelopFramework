//
//  YHPhotoCollectionViewCell.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/20.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHPhotoCollectionViewCell.h"

@interface YHPhotoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation YHPhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setImage:(UIImage *)image {

    _image = image;
    [self.imageView performSelector:@selector(setImage:) withObject:_image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
}

@end
