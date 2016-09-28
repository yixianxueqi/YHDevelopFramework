//
//  YHAssets.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/26.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef void(^YHAssetsToImageComplationBlock)(NSArray<UIImage *> *list);

@interface YHImageOption : NSObject

@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) PHImageContentMode contentModel;
@property (nonatomic,strong) PHImageRequestOptions *option;

@end

/**
 * @class  YHAssets
 *
 * @abstract 本地图片资源获取
 *
 */
@interface YHAssets : UIView

//获取所有资源
+ (PHFetchResult *)getAllAssets;
/**
 *  获取图片
 *
 *  @param asset  资源
 *  @param option 配置
 *  @param block  完成
 */
+ (void)getImageOfAsset:(PHAsset *)asset withOption:(YHImageOption *)option completionBlock:(YHAssetsToImageComplationBlock)block;
/**
 *  获取资源下所有图片
 *
 *  @param assetList 资源
 *  @param option    配置
 *  @param block     完成
 */
+ (void)getAllImageOfAssetList:(PHFetchResult *)assetList withOption:(YHImageOption *)option completionBlock:(YHAssetsToImageComplationBlock)block;


@end
