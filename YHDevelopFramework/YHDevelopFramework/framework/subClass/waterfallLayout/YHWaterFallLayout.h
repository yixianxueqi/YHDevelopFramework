//
//  YHWaterFallLayout.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/19.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHWaterFallLayout;
@protocol YHWaterFallLayoutDelegate <NSObject>
//获取item的高度
- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath layout:(YHWaterFallLayout *)layout;

@end

/**
 * @class  YHWaterFallLayout
 *
 * @abstract 竖向瀑布流布局
 *
 */
@interface YHWaterFallLayout : UICollectionViewFlowLayout
//列数
@property (nonatomic,assign) NSUInteger column;
@property (nonatomic,weak) id<YHWaterFallLayoutDelegate> delegate;

@end
