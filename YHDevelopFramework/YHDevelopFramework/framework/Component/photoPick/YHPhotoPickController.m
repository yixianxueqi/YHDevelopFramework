//
//  YHPhotoPickController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/13.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHPhotoPickController.h"
#import "YHPhotoPickCollectionViewCell.h"
#import "YHAssets.h"
#import "YHBottomView.h"
#import "YHPhotoPickHighImageCell.h"

#define kScreenSize [UIScreen mainScreen].bounds.size

NSString *const HIGH_IMAGE = @"highImage";
NSString *const LOW_IMAGE = @"lowImage";
NSString *const IMAGE_INFO = @"imageInfo";

static CGFloat const space = 3;
static CGFloat const lineItmeCount = 4;
static CGFloat const bottomViewHeight = 44;
static NSString *const lowImageCell = @"lowImageCell";
static NSString *const highImageCell = @"highImageCell";

@interface YHPhotoPickController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
//缩略图布局
@property (nonatomic,strong) UICollectionViewFlowLayout *lowFlowLayout;
//高清图布局
@property (nonatomic,strong) UICollectionViewFlowLayout *highFlowLayout;
//底部视图
@property (nonatomic,strong) YHBottomView *bottomView;
//缩略视图item宽度
@property (nonatomic,assign) CGFloat itemWidth;
//展示列表，缩略图
@property (nonatomic,strong) NSMutableArray *showList;
//大图缓存
@property (nonatomic,strong) NSMutableDictionary *highImageCache;
//选中列表
@property (nonatomic,strong) NSMutableArray *selectList;
//资源合集
@property (nonatomic,strong) PHFetchResult *assetsList;
//缩略图配置
@property (nonatomic,strong) YHImageOption *lowImageOption;
//高清图配置
@property (nonatomic,strong) YHImageOption *highImageOption;
//当前布局类型是否为大图
@property (nonatomic,assign) BOOL isHighLayout;


@end

@implementation YHPhotoPickController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self intializeView];
    self.isHighLayout = NO;
    [self getAssetsLibrary];
}

- (void)dealloc {

    NSLog(@"photo pick dealloc");
    [self.showList removeAllObjects];
    [self.highImageCache removeAllObjects];
}

#pragma mark - define

#pragma mark - private
//初始化UI
- (void)intializeView {

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YHPhotoPickCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:lowImageCell];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YHPhotoPickHighImageCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:highImageCell];
    [self.bottomView setSelectCountOfPhoto:0];
    [self.view addSubview:self.bottomView];
}
//获取Y值，区分push还是present转场
- (CGFloat)getTopY {

    CGFloat y;
    if (self.navigationController) {
        y = 64;
    } else {
        y = 20;
    }
    return y;
}
//获取选中照片
- (void)getSelectImages {
    
    NSMutableArray *imageList = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [self.selectList enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [weakSelf getHighImage:[obj integerValue] completion:^(UIImage *image) {
            [imageList addObject:@{LOW_IMAGE:weakSelf.showList[[obj integerValue]],HIGH_IMAGE:image,IMAGE_INFO:weakSelf.assetsList[[obj integerValue]]}];
            if (imageList.count == self.selectList.count && weakSelf.completionBlock) {
                weakSelf.completionBlock(imageList);
            }
        }];
    }];
}
//弹出提示达到选取界限
- (void)alertWarning {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"您最多可选%ld张",self.maxSelectCount] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
/********* 获取图片资源 ***********/
//获取缩略图片资源
- (void)getAssetsLibrary {
    
    __weak typeof(self) weakSelf = self;
    [YHAssets getAllImageOfAssetList:self.assetsList withOption:self.lowImageOption completionBlock:^(NSArray<UIImage *> *list) {
        [weakSelf.showList addObjectsFromArray:list];
        [weakSelf.collectionView reloadData];
    }];
}
//获取高清图资源
- (void)getHighImage:(NSInteger)index completion:(void(^)(UIImage *image))completion {

    __weak typeof(self) weakSelf = self;
    //优先查看缓存是否含有
    UIImage *image = [self.highImageCache objectForKey:@(index)];
    if (image && completion) {
        completion(image);
    } else {
        //获取高清图
        PHAsset *asset = self.assetsList[index];
        [YHAssets getImageOfAsset:asset withOption:self.highImageOption completionBlock:^(NSArray<UIImage *> *list) {
            [weakSelf.highImageCache setObject:[list firstObject] forKey:@(index)];
            if (completion) {
                completion([list firstObject]);
            }
        }];
    }
}

/********* 选取处理 ***********/
//单选处理
- (void)sigleSelectOfIndex:(NSInteger)index select:(BOOL)isSelect {
    
    if (isSelect) {
        [self.selectList removeAllObjects];
        [self.selectList addObject:@(index)];
    } else {
        [self.selectList removeAllObjects];
    }
    [self.collectionView reloadData];
    [self.bottomView setSelectCountOfPhoto:self.selectList.count];
}
//多选处理
- (void)mutableSelectOfIndex:(NSInteger)index select:(BOOL)isSelect {

    if (isSelect) {
        [self.selectList addObject:@(index)];
    } else {
        [self.selectList removeObject:@(index)];
    }
    [self.collectionView reloadData];
    [self.bottomView setSelectCountOfPhoto:self.selectList.count];
}
/********* 布局处理 ***********/
//更新布局至大图
- (void)transitionToHighLayout {

    self.isHighLayout = YES;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.alwaysBounceVertical = NO;
    self.collectionView.alwaysBounceHorizontal = YES;
    __weak typeof(self) weakSelf = self;
    [self.collectionView setCollectionViewLayout:self.highFlowLayout animated:NO completion:^(BOOL finished) {
        [weakSelf.collectionView reloadData];
    }];
}
//更新布局至缩略图
- (void)transitionToLowLayout {

    self.isHighLayout = NO;
    self.collectionView.pagingEnabled = NO;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.alwaysBounceHorizontal = NO;
    __weak typeof(self) weakSelf = self;
    [self.collectionView setCollectionViewLayout:self.lowFlowLayout animated:NO completion:^(BOOL finished) {
        [weakSelf.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.assetsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    //面向协议式编程，cell有统一的行为和回调，但样式和可扩展方向不一致，所以遵循协议实现统一的方法
    UICollectionViewCell<YHPhotoPickCellProtocol> *cell;
    if (self.isHighLayout) {
        //大图
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:highImageCell forIndexPath:indexPath];
        //解决cell复用图片闪烁问题
        [cell setImage:nil];
        [self getHighImage:indexPath.row completion:^(UIImage *image) {
            [cell setImage:image];
        }];
    } else {
        //缩略图
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:lowImageCell forIndexPath:indexPath];
        [cell setImage:self.showList[indexPath.row]];
    }
    //根据数据源更新视图选中状态
    if ([self.selectList containsObject:@(indexPath.row)]) {
        [cell setSelect];
    } else {
        [cell setUnSelect];
    }
    __weak typeof(self) weakSelf = self;
    cell.selectBlock = ^(BOOL isSelect) {
        if (weakSelf.maxSelectCount == 1) {
            [weakSelf sigleSelectOfIndex:indexPath.row select:isSelect];
        } else {
            if (isSelect && weakSelf.selectList.count >= weakSelf.maxSelectCount) {
                //弹窗提示达到上限
                [weakSelf alertWarning];
            } else {
                [weakSelf mutableSelectOfIndex:indexPath.row select:isSelect];
            }
        }
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.isHighLayout) {
        //跳转至缩略图布局
        [self transitionToLowLayout];
    } else {
        //跳转至大图布局
        [self transitionToHighLayout];
    }
}

#pragma mark - getter/setter
- (UICollectionView *)collectionView {

    if (!_collectionView) {
        CGFloat y = [self getTopY];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, y, kScreenSize.width, self.view.bounds.size.height - y - bottomViewHeight) collectionViewLayout:self.lowFlowLayout];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)lowFlowLayout {

    if (!_lowFlowLayout) {
        _lowFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _lowFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _lowFlowLayout.sectionInset = UIEdgeInsetsMake(0, space, 0, space);
        _lowFlowLayout.minimumLineSpacing = space;
        _lowFlowLayout.minimumInteritemSpacing = space;
        self.itemWidth = (self.view.bounds.size.width - space * (lineItmeCount + 1))/lineItmeCount;
        _lowFlowLayout.itemSize = CGSizeMake(self.itemWidth, self.itemWidth);
    }
    return _lowFlowLayout;
}

- (UICollectionViewFlowLayout *)highFlowLayout {

    if (!_highFlowLayout) {
        _highFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _highFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _highFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _highFlowLayout.minimumLineSpacing = 0;
        _highFlowLayout.minimumInteritemSpacing = 0;
        _highFlowLayout.itemSize = CGSizeMake(kScreenSize.width, self.collectionView.bounds.size.height);
    }
    return _highFlowLayout;
}

- (UIView *)bottomView {

    if (!_bottomView) {
        _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"YHBottomView" owner:nil options:nil] lastObject];
        _bottomView.frame = CGRectMake(0, self.view.bounds.size.height - bottomViewHeight, kScreenSize.width, bottomViewHeight);
        __weak typeof(self) weakSelf = self;
        _bottomView.certainBlock = ^{
            [weakSelf getSelectImages];
        };
    }
    return _bottomView;
}

- (NSMutableArray *)showList {

    if (!_showList) {
        _showList = [NSMutableArray array];
    }
    return _showList;
}

- (NSMutableDictionary *)highImageCache {

    if (!_highImageCache) {
        _highImageCache = [NSMutableDictionary dictionary];
    }
    return _highImageCache;
}

- (NSMutableArray *)selectList {

    if (!_selectList) {
        _selectList = [NSMutableArray array];
    }
    return _selectList;
}

- (PHFetchResult *)assetsList {

    if (!_assetsList) {
        _assetsList = [YHAssets getAllAssets];
    }
    return _assetsList;
}

- (YHImageOption *)lowImageOption {

    if (!_lowImageOption) {
        _lowImageOption = [[YHImageOption alloc] init];
        _lowImageOption.size = CGSizeMake(self.itemWidth * 2, self.itemWidth * 2);
        _lowImageOption.contentModel = PHImageContentModeAspectFit;
        PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
        _lowImageOption.option = requestOptions;
        
    }
    return _lowImageOption;
}

- (YHImageOption *)highImageOption {

    if (!_highImageOption) {
        _highImageOption = [[YHImageOption alloc] init];
        _highImageOption.size = CGSizeMake(kScreenSize.width * 2, kScreenSize.height * 2);
        _highImageOption.contentModel = PHImageContentModeAspectFit;
        PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
        _highImageOption.option = requestOptions;
    }
    return _highImageOption;

}

@end
