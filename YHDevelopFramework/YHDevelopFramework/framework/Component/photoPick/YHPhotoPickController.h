//
//  YHPhotoPickController.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/13.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHPhotoPickControllerProtocol <NSObject>

@optional

@end
/**
 * @class  YHPhotoPickController
 *
 * @abstract 照片选择器
 *
 */
@interface YHPhotoPickController : UIViewController

@property (nonatomic,weak) id<YHPhotoPickControllerProtocol> delegate;

@end
