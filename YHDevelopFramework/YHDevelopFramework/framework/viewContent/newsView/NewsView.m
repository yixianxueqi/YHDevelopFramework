//
//  NewsView.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/23.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NewsView.h"

#define kTitleBtnTag 201
#define kBottomSubViewTag 301

@interface NewsView ()<UICollectionViewDelegate,UICollectionViewDataSource>
//底部视图
@property (nonatomic,strong) UICollectionView *bottomView;
//标题视图
@property (nonatomic,strong) UIScrollView *titleView;
//记录标题项的宽度
@property (nonatomic,strong) NSMutableArray *widthList;
//标记是否超过一屏的大小，超过则流式平铺布局，不超过则平分当前屏幕大小
@property (nonatomic,assign) BOOL isOverWidth;
//记录标题总宽度
@property (nonatomic,assign) CGFloat titleWidth;
//当前选中
@property (nonatomic,assign) NSUInteger selectItem;
//底部子视图数组
@property (nonatomic,strong) NSMutableArray *bottomSubView;

@end

@implementation NewsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleViewHeight = 36.0;
        self.titleItemFontSize = 13.0;
        self.titleItemHeight = 20;
        self.titleItemSpace = 8.0;
        self.selectItem = 0;
    }
    return self;
}
#pragma mark - .h method

- (NSUInteger)getCurrentIndex {

    return self.selectItem;
}

- (UIView *)defineBottomView {
    //subclass must override this method
    return nil;
}

- (void)bottomViewDidDisplayAtIndex:(NSUInteger)index view:(UIView *)view {

    return;
}

#pragma mark - define
//布局子视图
- (void)customSubView {

    [self customTopTitleView];
    [self customBottomView];
    //默认选中第一个
    UIButton *btn = [self.titleView viewWithTag:kTitleBtnTag];
    [self clickTitleItemBtn:btn];
}

- (void)caculateWidth {

    CGFloat sum = self.titleItemSpace;
    for (NSString *str in self.titleList) {
        
        CGFloat width = [self stringWidth:str];
        [self.widthList addObject:@(width)];
        //item.width+间隙 = 总长度
        sum += width + self.titleItemSpace;
    }
    self.titleWidth = sum;
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
    
    return[str boundingRectWithSize:CGSizeMake(MAXFLOAT, self.titleItemHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.titleItemFontSize]} context:nil].size.width + self.titleItemSpace * 2;
}

#pragma mark - incident
//点击标题事件
- (void)clickTitleItemBtn:(UIButton *)btn {
    
    [self selectTitelItem:btn];
    [self scrollBottom];
}
//设置标题选中
- (void)selectTitelItem:(UIButton *)btn {
    //取消上一个选中的
    UIButton *preBtn = [self.titleView viewWithTag:kTitleBtnTag + self.selectItem];
    preBtn.selected = NO;
    btn.selected = YES;
    self.selectItem = btn.tag - kTitleBtnTag;
    [self scrollBtnSelect:btn];
}
//标题滑动到选中且居中
- (void)scrollBtnSelect:(UIButton *)btn {

    CGFloat itemX = btn.center.x;
    CGFloat beginX = self.bounds.size.width * 0.5;
    CGFloat endX = self.titleView.contentSize.width - self.bounds.size.width * 0.5;
    if (itemX < beginX) {
        //回到最左边
        [self.titleView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (itemX > endX) {
        //回到最右边
        CGFloat offsetX = self.titleView.contentSize.width - self.bounds.size.width;
        [self.titleView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    } else {
        //需要调整居中区域
        CGPoint offsetPoint = CGPointMake(btn.center.x - beginX, 0);
        [self.titleView setContentOffset:offsetPoint animated:YES];
    }
    //此视图完整展现
    NSUInteger index = btn.tag - kTitleBtnTag;
    [self bottomViewDidDisplayAtIndex:index view:self.bottomSubView[index]];
}
//活动底部视图
- (void)scrollBottom {
    
    [self.bottomView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectItem inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - TopTitleView
- (void)customTopTitleView {

    self.titleView = [[UIScrollView alloc] init];
    [self addSubview:self.titleView];
    self.titleView.frame = CGRectMake(0, 0, self.bounds.size.width, self.titleViewHeight);
    self.titleView.showsHorizontalScrollIndicator = NO;
    if (self.isOverWidth) {
        self.titleView.contentSize = CGSizeMake(self.titleWidth, 0);
    } else {
        self.titleView.contentSize = CGSizeMake(self.bounds.size.width, 0);
    }
    CGPoint prePoint = CGPointZero;
    CGFloat midY = (self.titleViewHeight - self.titleItemHeight) * 0.5 + self.titleItemHeight * 0.5;
    for (int i = 0; i < self.titleList.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [self.titleView addSubview:btn];
        btn.tag = i + kTitleBtnTag;
        [btn addTarget:self action:@selector(clickTitleItemBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:self.titleItemFontSize];
        [btn setTitle:self.titleList[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        if (self.isOverWidth) {
            //流式平铺
            btn.bounds = CGRectMake(0, 0, [self.widthList[i] doubleValue], self.titleItemHeight);
            CGFloat itemX = prePoint.x + self.titleItemSpace + [self.widthList[i] doubleValue] * 0.5;
            btn.center = CGPointMake(itemX, midY);
            prePoint = CGPointMake(CGRectGetMaxX(btn.frame), 0);
        } else {
            //平分当前屏幕
            CGFloat itemWidth = self.bounds.size.width / self.titleList.count;
            btn.bounds = CGRectMake(0, 0, itemWidth, self.titleItemHeight);
            CGFloat itemX = prePoint.x + itemWidth * 0.5;
            btn.center = CGPointMake(itemX, midY);
            prePoint = CGPointMake(CGRectGetMaxX(btn.frame), 0);
        }
    }
}

#pragma mark - BottomView
- (void)customBottomView {
    
    [self getBottomDefineView];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.bottomView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.titleViewHeight, self.bounds.size.width, self.bounds.size.height - self.titleViewHeight) collectionViewLayout:flowLayout];
    [self addSubview:self.bottomView];
    self.bottomView.delegate = self;
    self.bottomView.dataSource = self;
    [self.bottomView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.bottomView.showsHorizontalScrollIndicator = NO;
    self.bottomView.showsVerticalScrollIndicator = NO;
    self.bottomView.pagingEnabled = YES;
    self.bottomView.backgroundColor = [UIColor whiteColor];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height - self.titleViewHeight);
    
}
//获取底部自定义视图
- (void)getBottomDefineView {

    for (int i = 0; i < self.titleList.count; i++) {
        [self.bottomSubView addObject:[self defineBottomView]];
    }
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.titleList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //移除子视图
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    //添加视图
    UIView *view = self.bottomSubView[indexPath.row];
    [cell.contentView addSubview:view];
    view.tag = kBottomSubViewTag + indexPath.row;
    view.frame = cell.contentView.bounds;
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    double index = self.bottomView.contentOffset.x / self.bounds.size.width;
    if (index == (NSUInteger)index) {
        //调整标题选中项
        UIButton *btn = [self.titleView viewWithTag:index + kTitleBtnTag];
        [self selectTitelItem:btn];
    }
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

- (NSMutableArray *)bottomSubView {

    if (!_bottomSubView) {
        _bottomSubView = [NSMutableArray array];
    }
    return _bottomSubView;
}

@end
