//
//  FlowContentView.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/23.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlowItemProtocol <NSObject>

@optional
//自定义按钮属性
- (UIButton *)customButtonAttribute:(UIButton *)button;
//按钮被点击时
- (void)itemClickIncident:(NSInteger)index;

@end

/**
 * @class  FlowContentView
 *
 * @abstract 横向流式布局
 *
 */
@interface FlowContentView : UIView

@property (nonatomic,strong) NSArray *itemList;
@property (nonatomic,weak) id<FlowItemProtocol> delegate;
/*
    下列属性需要在赋值数组前赋值
*/
//item 高度，默认18.0
@property (nonatomic,assign) CGFloat itemHeight;
//item 字体大小，默认13.0
@property (nonatomic,assign) CGFloat itemFontSize;
//列间距，默认10.0
@property (nonatomic,assign) CGFloat rowSpace;
//行间距，默认10.0
@property (nonatomic,assign) CGFloat lineSpace;

@end
