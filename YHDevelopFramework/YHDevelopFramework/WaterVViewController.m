//
//  WaterVViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/19.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "WaterVViewController.h"
#import "YHWaterFallLayout.h"

@interface WaterVViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,YHWaterFallLayoutDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation WaterVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"瀑布流";
    regClsCellC(self.collectionView, [UICollectionViewCell class], @"cell");
    
}
#pragma mark -define

- (NSUInteger)randomNum {

    return arc4random_uniform(100);
}

- (UIColor *)randomColor {

    NSUInteger num = [self randomNum];
    NSInteger index = num % 3;
    UIColor *color;
    if (index == 0) {
        color = [UIColor redColor];
    } else if (index == 1) {
        color = [UIColor redColor];
    } else {
        color = [UIColor redColor];
    }
    return color;
}

- (CGFloat)getHight:(NSUInteger)index {
    
    NSUInteger num = index % 3;
    if (num == 0) {
        return 30;
    } else if (num == 1) {
        return 40;
    } else {
        return 70;
    }
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath layout:(YHWaterFallLayout *)layout {

    return [self getHight:indexPath.row];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 99;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - getter/setter
- (UICollectionView *)collectionView {

    if (!_collectionView) {
        YHWaterFallLayout *waterLayout = [[YHWaterFallLayout alloc] init];
        waterLayout.column = 3;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:waterLayout];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        waterLayout.delegate = self;
        waterLayout.minimumLineSpacing = 10;
        waterLayout.minimumInteritemSpacing = 10;
        waterLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        waterLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
    }
    return _collectionView;
}

@end
