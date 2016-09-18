//
//  YHPhotoThroughViewController.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/14.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHPhotoThroughDelegate <NSObject>

@optional
- (void)touchSigleViewIncident;

@end
/**
 * @class  YHPhotoThroughViewController
 *
 * @abstract 图片浏览器
 *
 */
@interface YHPhotoThroughViewController : UIViewController

@property (nonatomic,strong) NSArray<UIImage *> *imageList;
@property (nonatomic,weak) id<YHPhotoThroughDelegate> delegate;

@end
