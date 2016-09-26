//
//  YHPhotoManager.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/19.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHPhotoAssets.h"

@interface YHPhotoOption : NSObject

@property (nonatomic,strong) NSArray<PHAsset *> *assetList;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) PHImageContentMode contentModel;
@property (nonatomic,strong) PHImageRequestOptions *options;

@end

#pragma mark - YHPhotoManager
@interface YHPhotoManager : NSObject

+ (instancetype)defaultManager;
//获取单张图片
- (void)getImageWithPhotoOption:(YHPhotoOption *)option;
//获取一组图片
- (void)getImagesWithPhotoOption:(YHPhotoOption *)option;

@end
