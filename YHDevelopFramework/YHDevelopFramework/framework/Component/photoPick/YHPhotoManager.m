//
//  YHPhotoManager.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/19.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHPhotoManager.h"

@interface YHPhotoOption ()

@end

#pragma mark - YHPhotoManager
@interface YHPhotoManager ()

@property (nonatomic,strong) PHImageManager *imageManager;
@property (nonatomic,strong) PHCachingImageManager *cachingImageManager;

@end

@implementation YHPhotoManager

#pragma mark - life cycle
static YHPhotoManager *manager;
+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - define

- (void)getImageWithPhotoOption:(YHPhotoOption *)option {

    [self.imageManager requestImageForAsset:[option.assetList firstObject] targetSize:option.size contentMode:option.contentModel options:option.options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
    }];
}

- (void)getImagesWithPhotoOption:(YHPhotoOption *)option {

    [self.cachingImageManager startCachingImagesForAssets:option.assetList targetSize:option.size contentMode:option.contentModel options:option.options];
}

#pragma mark - getter/setter
- (PHImageManager *)imageManager {

    if (!_imageManager) {
        _imageManager = [PHImageManager defaultManager];
    }
    return _imageManager;
}

- (PHCachingImageManager *)cachingImageManager {

    if (!_cachingImageManager) {
        _cachingImageManager = [[PHCachingImageManager alloc] init];
    }
    return _cachingImageManager;
}

@end
