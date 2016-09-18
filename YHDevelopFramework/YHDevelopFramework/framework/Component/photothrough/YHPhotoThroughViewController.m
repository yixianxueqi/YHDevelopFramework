//
//  YHPhotoThroughViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/14.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHPhotoThroughViewController.h"
#import "YHPhotoThroughCell.h"

@interface YHPhotoThroughViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UILabel *pageLabel;

@end

@implementation YHPhotoThroughViewController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self customView];
}

#pragma mark - private

- (void)customView {

    [self.view addSubview:self.collectionView];
    [self addPageNumber];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YHPhotoThroughCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView reloadData];
}

- (void)addPageNumber {

    [self.view addSubview:self.pageLabel];
    [self changeNumber:0];
}

- (void)changeNumber:(NSUInteger)index {

    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",index+1,self.imageList.count];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    
    YHPhotoThroughCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.image = self.imageList[indexPath.row];
    __weak typeof(self) weakSelf = self;
    cell.tapSigleHandleBlock = ^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(touchSigleViewIncident)]) {
            [weakSelf.delegate touchSigleViewIncident];
        }
    };
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return self.view.bounds.size;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self changeNumber:indexPath.row];
}

#pragma mark - getter/setter

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
    }
    return _collectionView;
}

- (UILabel *)pageLabel {

    if (!_pageLabel) {
        CGSize size = self.view.bounds.size;
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height - 44, size.width, 44)];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.font = [UIFont systemFontOfSize:15.0];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _pageLabel;
}

@end
