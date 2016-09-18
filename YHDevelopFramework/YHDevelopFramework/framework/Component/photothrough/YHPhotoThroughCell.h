//
//  YHPhotoThroughCell.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/14.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPhotoThroughCell : UICollectionViewCell

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,copy) void(^tapSigleHandleBlock)(void);

@end
