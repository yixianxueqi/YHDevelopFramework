//
//  YHPhotoAssets.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/19.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef void(^assetsLibrary)(NSArray *list);

/**
 * @class  YHPhotoAssets
 *
 * @abstract 图片资源获取
 *
 */
@interface YHPhotoAssets : NSObject

- (void)getAssetsCompletion:(assetsLibrary)block;

@end
