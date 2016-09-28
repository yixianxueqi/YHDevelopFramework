//
//  YHPhotoPickCellProtocol.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/28.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PhotoCellSelectBlock)(BOOL isSelect);

@protocol YHPhotoPickCellProtocol <NSObject>

@property (nonatomic,copy) PhotoCellSelectBlock selectBlock;

@required
- (void)setImage:(UIImage *)image;
- (void)setUnSelect;
- (void)setSelect;

@end
