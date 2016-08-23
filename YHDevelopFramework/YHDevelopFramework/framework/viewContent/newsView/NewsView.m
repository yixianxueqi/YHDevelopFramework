//
//  NewsView.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/23.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NewsView.h"

@interface NewsView ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIScrollView *titleView;
@property (nonatomic,strong) NSMutableArray *widthList;
@property (nonatomic,assign) BOOL isOverWidth;

@end

@implementation NewsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleViewHeight = 30.0;
        self.titleItemFontSize = 13.0;
        self.titleItemHeight = 20;
    }
    return self;
}

#pragma mark - define
//布局子视图
- (void)customSubView {

    [self customTopTitleView];
    [self customBottomView];
    NSLog(@"test branch,test,test");
}

- (void)caculateWidth {

    CGFloat sum = 0;
    for (NSString *str in self.titleList) {
        
        CGFloat width = [self stringWidth:str];
        [self.widthList addObject:@(width)];
        sum += width;
    }
    if (sum >= self.bounds.size.width) {
        //超出容器宽度
        self.isOverWidth = YES;
    } else {
        //未超出容器宽度
        self.isOverWidth = NO;
    }
}
//计算文本宽度
- (CGFloat)stringWidth:(NSString *)str {
    
    return[str boundingRectWithSize:CGSizeMake(MAXFLOAT, self.titleItemHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.titleItemFontSize]} context:nil].size.width + 16;
}

#pragma mark - TopTitleView
- (void)customTopTitleView {

    self.titleView = [[UIScrollView alloc] init];
    [self addSubview:self.titleView];
    self.titleView.frame = self.bounds;
    
}

#pragma mark - BottomView
- (void)customBottomView {

}
#pragma mark - getter/setter

- (void)setTitleList:(NSArray *)titleList {

    _titleList = titleList;
    [self caculateWidth];
    [self customSubView];
}

- (NSMutableArray *)widthList {

    if (!_widthList) {
        _widthList = [NSMutableArray array];
    }
    return _widthList;
}

@end
