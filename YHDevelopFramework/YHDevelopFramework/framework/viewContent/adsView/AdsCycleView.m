//
//  AdsCycleView.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/13.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "AdsCycleView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define kWidth [UIScreen mainScreen].bounds.size.width

@interface AdsCycleView ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray<UIImageView *> *imgViewList;
@property (nonatomic,strong) NSMutableArray<NSString *> *titleList;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSUInteger pageControlAlignment;
@property (nonatomic,assign) BOOL isNeedTitle;
@property (nonatomic,assign) BOOL isNeedPageControl;
@property (nonatomic,assign) BOOL isAuto;
@property (nonatomic,assign) CGFloat seconds;

@end

@implementation AdsCycleView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pageControlAlignment = PageContrlRightAlignment;
        self.isNeedTitle = NO;
        self.isNeedPageControl = YES;
        self.isAuto = YES;
        self.seconds = 5.f;
    }
    return self;
}

- (void)dealloc {

    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - define

- (void)setImageListWithUrlString:(NSArray<NSString *> *)list placeHoldImage:(UIImage *)image {
    
    if (list.count == 0) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [list enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *igv = [weakSelf getImageView];
        [igv sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:image];
        [weakSelf.imgViewList addObject:igv];
    }];
    //无限轮播，元素比原本多两个，首尾各加一个
    UIImageView *igvS = [self getImageView];
    [igvS sd_setImageWithURL:[NSURL URLWithString:[list firstObject]] placeholderImage:image];
    [self.imgViewList addObject:igvS];
    UIImageView *igvE = [self getImageView];
    [igvE sd_setImageWithURL:[NSURL URLWithString:[list lastObject]] placeholderImage:image];
    [self.imgViewList insertObject:igvE atIndex:0];
    
    [self customView];
}

- (void)setImageList:(NSArray<UIImage *> *)list {

    __weak typeof(self) weakSelf = self;
    [list enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *igv = [weakSelf getImageView];
        igv.image = obj;
        [weakSelf.imgViewList addObject:igv];
    }];
    //无限轮播，元素比原本多两个，首尾各加一个
    UIImageView *igvS = [self getImageView];
    igvS.image = [list firstObject];
    [self.imgViewList addObject:igvS];
    UIImageView *igvE = [self getImageView];
    igvE.image = [list lastObject];
    [self.imgViewList insertObject:igvE atIndex:0];
    
    [self customView];
}

- (void)setExplanationOfImageList:(NSArray <NSString *> *)list {

    [self.titleList addObjectsFromArray:list];
    NSString *str = [list firstObject];
    [self.titleList insertObject:[list lastObject] atIndex:0];
    [self.titleList addObject:str];
}

- (void)setPageControl:(UIPageControl *)pageControl alignMent:(PageContrlAlignment)alignment {
    
    self.pageControl = pageControl;
    self.pageControlAlignment = alignment;
}
- (void)isNeedExplanation:(BOOL)isNeed {

    self.isNeedTitle = isNeed;
}
- (void)isNeedPageControl:(BOOL)isNeed {

    self.isNeedPageControl = isNeed;
}
- (void)isAutoCycleShow:(BOOL)isAuto {
    self.isAuto = isAuto;
}
- (void)autoCycleSeconds:(CGFloat)seconds {
    self.seconds = seconds;
}
- (void)stopTimer {

    [self.timer setFireDate:[NSDate distantFuture]];
}
- (void)resumTimer {

    [self.timer setFireDate:[NSDate distantPast]];
}
#pragma mark - response
//点击事件
- (void)clickImageView:(UITapGestureRecognizer *)tap {

    UIImageView *igv = (UIImageView *)tap.view;
    NSInteger index = igv.tag - 1;
    if (self.clickIncidentBlock) {
        self.clickIncidentBlock(index);
    }
}
//定时器
- (void)timeGo {
    
    CGFloat width = self.scrollView.contentOffset.x + kWidth;
    [self.scrollView scrollRectToVisible:CGRectMake(width, 0, kWidth, self.bounds.size.height) animated:YES];
    [self.scrollView setContentOffset:CGPointMake(width, 0) animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cycleMove:width];        
    });
}

#pragma mark - private
//获得UIImageView
- (UIImageView *)getImageView {

    UIImageView *igv = [[UIImageView alloc] init];
    igv.contentMode = UIViewContentModeScaleToFill;
    igv.backgroundColor = [UIColor whiteColor];
    igv.userInteractionEnabled = YES;
    return igv;
}
//布局视图
- (void)customView {

    CGFloat height = self.bounds.size.height;
    self.scrollView.frame = CGRectMake(0, 0, kWidth, height);
    self.scrollView.contentSize = CGSizeMake(self.imgViewList.count * kWidth, 0);
    if (self.isNeedPageControl) {
        [self addPageControl];        
    }
    __weak typeof(self) weakSelf = self;
    [self.imgViewList enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bounds = CGRectMake(0, 0, kWidth, height);
        obj.center = CGPointMake((idx + 0.5)*kWidth, height * 0.5);
        obj.tag = idx + 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
        [obj addGestureRecognizer:tap];
        if (weakSelf.isNeedTitle) {
            [weakSelf addTitle:self.titleList[idx] onImageView:obj];
        }
        [weakSelf.scrollView addSubview:obj];
    }];
    if (self.isAuto) {
        [self.timer fire];
    } else {
        [self.scrollView setContentOffset:CGPointMake(kWidth, 0) animated:NO];
    }
}
//添加文字说明在UIImageView
- (void)addTitle:(NSString *)title onImageView:(UIImageView *)imageView {

    if (title.length == 0 || !imageView) {
        return;
    }
    CGFloat space = self.pageControl.bounds.size.width + 16 + 8 + 20;
    CGFloat height = [self stringHeightWithString:title width:kWidth-space fontSize:11.0] + 16;
    CGFloat bgViewY = self.bounds.size.height - height;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, bgViewY, kWidth, height)];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [imageView addSubview:bgView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, kWidth-space, height - 16)];
    [bgView addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:11.0];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 2;
    label.text = title;
}
//添加分页控制
- (void)addPageControl {

    if (!self.pageControl) {
        return;
    }
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.imgViewList.count - 2;
    CGFloat height = self.bounds.size.height;
    CGSize size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    CGFloat pageControlY = height - size.height;
    if (self.pageControlAlignment == PageContrlRightAlignment) {
        self.pageControl.frame = CGRectMake(kWidth - size.width - 16,pageControlY,size.width, size.height);
    } else if (self.pageControlAlignment == PageContrlCenterAlignment) {
        self.pageControl.frame = CGRectMake((kWidth - size.width)*0.5, pageControlY, size.width, size.height);
    } else {
        self.pageControl.frame = CGRectMake(16, pageControlY, size.width, size.height);
    }
    [self addSubview:self.pageControl];
}
//获取文字高度
- (CGFloat)stringHeightWithString:(NSString *)str width:(CGFloat)width fontSize:(CGFloat)size {
    
   return [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size.height;
}
//滚动调整视图
- (void)cycleMove:(CGFloat)moveX {

    NSInteger index = moveX/ kWidth;
    if (index == self.imgViewList.count -1) {
        [self.scrollView setContentOffset:CGPointMake(kWidth, 0) animated:NO];
        self.pageControl.currentPage = 0;
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(kWidth*(self.imgViewList.count -2), 0) animated:NO];
        self.pageControl.currentPage = self.pageControl.numberOfPages-1;
    } else {
        self.pageControl.currentPage = index-1;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self cycleMove:scrollView.contentOffset.x];
}

#pragma mark - getter/setter

- (NSMutableArray<UIImageView *> *)imgViewList {

    if (!_imgViewList) {
        _imgViewList = [NSMutableArray array];
    }
    return _imgViewList;
}

- (NSMutableArray<NSString *> *)titleList {

    if (!_titleList) {
        _titleList = [NSMutableArray array];
    }
    return _titleList;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (NSTimer *)timer {

    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.seconds target:self selector:@selector(timeGo) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}

@end
