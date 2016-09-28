//
//  YHPhotoPickController.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/13.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const HIGH_IMAGE;
extern NSString *const LOW_IMAGE;
extern NSString *const IMAGE_INFO;

typedef void(^PhotoPickCompletionBlock)(NSArray<UIImage *> *imageList);

/**
 * @class  YHPhotoPickController
 *
 * @abstract 照片选择器
 *
 */
@interface YHPhotoPickController : UIViewController

//照片最多选取限制，最小为1
@property (nonatomic,assign) NSUInteger maxSelectCount;
@property (nonatomic,copy) PhotoPickCompletionBlock completionBlock;

@end
