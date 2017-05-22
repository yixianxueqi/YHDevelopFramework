//
//  NewContentView.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/24.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NewContentView.h"
#import "NewsTableViewDelegate.h"
#import <MJRefresh/MJRefresh.h>

@interface NewContentView ()

@property (nonatomic,strong) NSMutableArray *sumDelegate;

@end

@implementation NewContentView

#pragma mark - ovveride
/**
 *  自定义底部视图
 *
 *  @notice 子类必须重写此方法
 *  @return UIView
 */
- (UIView *)defineBottomView {
    
   return [self getTabelView];
}
/**
 *  底部子视图完整显示走此方法
 *
 *  @notice 子类可选重写此方法
 *  @param index 序号(0,1,2...)
 */
- (void)bottomViewDidDisplayAtIndex:(NSUInteger)index view:(UIView *)view {
    
    NSLog(@"did appear,%ld",index);
    //当没有值时刷新，有值不刷新
    NewsTableViewDelegate *delegate = self.sumDelegate[index];
    if (delegate.dataSource.count == 0) {
        UITableView *tableView = (UITableView *)view;
        [tableView.mj_header beginRefreshing];
    }
}
#pragma mark - define

- (UITableView *)getTabelView {

    UITableView *tbView =[[UITableView alloc] init];
    NewsTableViewDelegate *delegate = [[NewsTableViewDelegate alloc] init];
    tbView.delegate = delegate;
    tbView.dataSource = delegate;
    [self.sumDelegate addObject:delegate];
    tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NewsTableViewDelegate *delegate = self.sumDelegate[[self getCurrentIndex]];
            delegate.dataSource = @[@"1",@"2",@"3"];
            [tbView.mj_header endRefreshing];
            [tbView reloadData];
        });
    }];
    [tbView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    return tbView;
}

#pragma mark - getter/setter
- (void)setList:(NSMutableArray *)list {

    _list = list;
    self.titleList = list;
}
- (NSMutableArray *)sumDelegate {

    if(!_sumDelegate){
        _sumDelegate = [NSMutableArray array];
    }
    return _sumDelegate;
}

@end
