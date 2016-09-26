//
//  YHPhotoPickController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/13.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHPhotoPickController.h"
#import "YHPhotoAssets.h"
#import "YHPhotoCollectionViewCell.h"
#import "YHPhotoManager.h"

#define kSize [UIScreen mainScreen].bounds.size

static CGFloat const space = 2;

@interface YHPhotoPickController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) YHPhotoAssets *assets;
@property (nonatomic,strong) NSArray *assetsList;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) YHPhotoOption *fastPhotoOption;

@end

@implementation YHPhotoPickController

#pragma mark - life cycle

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getAssets];
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YHPhotoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - define
- (void)getAssets {

    self.assets = [[YHPhotoAssets alloc] init];
    __weak typeof(self) weakSelf = self;
    [self.assets getAssetsCompletion:^(NSArray *list) {
        weakSelf.assetsList = list;
        NSLog(@"assetsList: %@",list);
        [weakSelf.collectionView reloadData];
    }];
}
#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.assetsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    
    YHPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    PHAsset *asset = self.assetsList[indexPath.row];
    [[YHPhotoManager defaultManager] getImageWithPhotoOption:(YHPhotoOption *)]
    cell.image = nil;
    return cell;
}

#pragma mark - getter/setter
- (UICollectionView *)collectionView {

    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        flowLayout.minimumLineSpacing = space;
        flowLayout.minimumInteritemSpacing = space;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, space, 0, space);
        CGFloat width = (kSize.width - 5 * space)/4;
        self.fastPhotoOption.size = CGSizeMake(width, width);
        flowLayout.itemSize = CGSizeMake(width, width);
    }
    return _collectionView;
}

- (YHPhotoOption *)fastPhotoOption {

    if (!_fastPhotoOption) {
        _fastPhotoOption = [[YHPhotoOption alloc] init];
        _fastPhotoOption.contentModel = PHImageContentModeAspectFit;
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        _fastPhotoOption.options = option;
    }
    return _fastPhotoOption;
}

@end
