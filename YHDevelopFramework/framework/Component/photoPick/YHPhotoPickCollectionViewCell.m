//
//  YHPhotoPickCollectionViewCell.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/26.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHPhotoPickCollectionViewCell.h"


@interface YHPhotoPickCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation YHPhotoPickCollectionViewCell

@synthesize selectBlock;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
}

- (void)setImage:(UIImage *)image {
    
    [self.imageView setImage:image];
}

- (void)setUnSelect {

    self.selectBtn.selected = NO;
}

- (void)setSelect {

    self.selectBtn.selected = YES;
}
- (IBAction)clickBtn:(UIButton *)sender {
    
    if (self.selectBlock) {
        self.selectBlock(!sender.selected);
    }
}

@end
