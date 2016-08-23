//
//  NewsView.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/23.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @class  NewsView
 *
 * @abstract 类似于新闻视图，上方一溜标题，下方对应视图，上或下左右滑动皆可引起对方滑动
 *
 */
@interface NewsView : UIView

@property (nonatomic,strong) NSArray *titleList;
@property (nonatomic,assign) CGFloat titleViewHeight;
@property (nonatomic,assign) CGFloat titleItemHeight;
@property (nonatomic,assign) CGFloat titleItemFontSize;

@end
