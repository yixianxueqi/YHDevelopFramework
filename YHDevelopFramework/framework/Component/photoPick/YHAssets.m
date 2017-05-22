//
//  YHAssets.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/26.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHAssets.h"

@implementation YHImageOption

@end

#pragma mark - YHAssets
@interface YHAssets ()

@end

@implementation YHAssets

#pragma mark - define
//获取所有图片资源
+ (PHFetchResult *)getAllAssets {

    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:options];
    return assetsFetchResults;
}

+ (void)getImageOfAsset:(PHAsset *)asset withOption:(YHImageOption *)option completionBlock:(YHAssetsToImageComplationBlock)block {

    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    if (asset.mediaType == PHAssetMediaTypeImage) {
        [imageManager requestImageForAsset:asset
                                targetSize:option.size
                               contentMode:option.contentModel
                                   options:option.option
                             resultHandler:^(UIImage *result, NSDictionary *info) {
                                 // 得到一张高清 UIImage
                                 if (result && block && ![info[PHImageResultIsDegradedKey] boolValue]) {
                                     block(@[result]);
                                 }
                             }];
    }
}

+ (void)getAllImageOfAssetList:(PHFetchResult *)assetList withOption:(YHImageOption *)option completionBlock:(YHAssetsToImageComplationBlock)block {

    NSMutableArray *list = [NSMutableArray array];
    __block NSUInteger count = 0;
    [assetList enumerateObjectsUsingBlock:^(PHAsset *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.mediaType == PHAssetMediaTypeImage) {
            count += 1;
        }
    }];
    [assetList enumerateObjectsUsingBlock:^(PHAsset *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.mediaType == PHAssetMediaTypeImage) {
            PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
            [imageManager requestImageForAsset:obj
                                    targetSize:option.size
                                   contentMode:option.contentModel
                                       options:option.option
                                 resultHandler:^(UIImage *result, NSDictionary *info) {
                                     // 得到一张 UIImage
                                     if (result) {
                                         [list addObject:result];
                                         if (count == list.count && block) {
                                             block(list);
                                         }
                                     }
                                 }];
        }
    }];
}

#pragma mark - private


@end
