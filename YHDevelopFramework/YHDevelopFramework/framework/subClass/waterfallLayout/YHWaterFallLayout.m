//
//  YHWaterFallLayout.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/19.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHWaterFallLayout.h"

@interface YHWaterFallLayout ()
//记录位置信息
@property (nonatomic,strong) NSMutableArray *attributesList;
@property (nonatomic,strong) NSMutableDictionary *maxYDic;
@property (nonatomic,assign) CGFloat itemWidth;

@end

@implementation YHWaterFallLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.column = 3;
    }
    return self;
}

- (void)prepareLayout {
    
    [super prepareLayout];
    //计算每隔item的宽度,(容器视图宽度-左右间距-列间距)/列数
    self.itemWidth = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - 2 * self.minimumInteritemSpacing)/self.column;
    for (int i = 0; i < self.column; i++) {
        [self.maxYDic setObject:@(self.sectionInset.top) forKey:@(i)];
    }
    NSUInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    [self.attributesList removeAllObjects];
    for (int i = 0; i < itemCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [self.attributesList addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize {

    __block NSNumber *maxIndex = @0;
    //遍历字典，找出最长的那一列
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.maxYDic[maxIndex] floatValue] < obj.floatValue) {
            maxIndex = key;
        }
    }];
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue] + self.sectionInset.bottom);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    return self.attributesList;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {

     UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    __block NSNumber *minIndex = @0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.maxYDic[minIndex] floatValue] > obj.floatValue) {
            minIndex = key;
        }
    }];
    CGFloat itemX = self.sectionInset.left + (self.minimumInteritemSpacing + self.itemWidth) * minIndex.integerValue;
    CGFloat itemY = [self.maxYDic[minIndex] floatValue] + self.minimumLineSpacing;
    //获取高度
    CGFloat height;
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForIndexPath:layout:)]) {
        height = [self.delegate heightForIndexPath:indexPath layout:self];
    }
    //设置attributes的frame
    attributes.frame = CGRectMake(itemX, itemY, self.itemWidth, height);
    //更新字典中的最短列的最大y值
    self.maxYDic[minIndex] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return !CGRectEqualToRect(self.collectionView.bounds, newBounds);
}

#pragma mark - getter/setter
- (NSMutableDictionary *)maxYDic {

    if (!_maxYDic) {
        _maxYDic = [NSMutableDictionary dictionary];
    }
    return _maxYDic;
}
- (NSMutableArray *)attributesList {

    if (!_attributesList) {
        _attributesList = [NSMutableArray array];
    }
    return _attributesList;
}

@end
