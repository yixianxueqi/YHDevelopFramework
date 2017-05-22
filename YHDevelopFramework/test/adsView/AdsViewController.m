//
//  AdsViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/13.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "AdsViewController.h"
#import "AdsCycleView.h"
#import "YHPageControl.h"

@interface AdsViewController ()

@property (nonatomic,strong) AdsCycleView *adsView;;
@property (nonatomic,strong) YHPageControl *pageControl;

@end

@implementation AdsViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.adsView];
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    NSMutableArray *tempList = [NSMutableArray array];
    for (int i = 1; i < 6; i++) {
        [tempList addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]]];
    }
    [self.adsView setExplanationOfImageList:@[@"123撒娇的撒娇的痕迹爱打架",@"abc按时打卡上加大快接啊看看大大龙会计师大楼就撒娇大手大脚卡就卡了的骄",@"def",@"qwe",@"rdf"]];
    [self.adsView setPageControl:self.pageControl alignMent:PageContrlRightAlignment];
    [_adsView isNeedExplanation:YES];
//    [_adsView isNeedPageControl:NO];
    [self.adsView setImageList:tempList];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.adsView stopTimer];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.adsView resumTimer];
    });
}

#pragma mark - getter/setter

- (AdsCycleView *)adsView {

    if (!_adsView) {
        _adsView = [[AdsCycleView alloc] initWithFrame:CGRectMake(0, 200, [UIView screenWidth], 150)];
        _adsView.clickIncidentBlock = ^(NSInteger index){
            NSLog(@"%ld",index);
        };
    }
    return _adsView;
}

- (YHPageControl *)pageControl {

    if(!_pageControl){
        _pageControl = [[YHPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [_pageControl setPointSize:CGSizeMake(10, 10)];
    }
    return _pageControl;
}

@end
