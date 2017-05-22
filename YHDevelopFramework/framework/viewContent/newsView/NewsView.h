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

//标题数组
@property (nonatomic,strong) NSArray *titleList;
/**
 *  下列属性赋值需要在赋值数组前进行
 */
//标题栏容器高度,默认36.0
@property (nonatomic,assign) CGFloat titleViewHeight;
//标题项高度，默认20.0
@property (nonatomic,assign) CGFloat titleItemHeight;
//标题项字体大小，默认13.0
@property (nonatomic,assign) CGFloat titleItemFontSize;
//标题间间隙，默认8.0
@property (nonatomic,assign) CGFloat titleItemSpace;

//获取当前选中项（0,1,2..）
- (NSUInteger)getCurrentIndex;
/**
 *  自定义底部视图
 *
 *  @notice 子类必须重写此方法
 *  @return UIView
 */
- (UIView *)defineBottomView;
/**
 *  底部子视图完整显示走此方法
 *
 *  @notice 子类可选重写此方法
 *  @param index 序号(0,1,2...)
 */
- (void)bottomViewDidDisplayAtIndex:(NSUInteger)index view:(UIView *)view;

@end
