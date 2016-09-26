//
//  YHPhotoAssets.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/19.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHPhotoAssets.h"

@interface YHPhotoAssets ()

@property (nonatomic,strong) NSMutableArray *assets;
@property (nonatomic,copy) assetsLibrary block;

@end

@implementation YHPhotoAssets

#pragma mark - define

- (void)getAssetsCompletion:(assetsLibrary)block {

    self.block = block;
    [self loadAssets];
}

#pragma mark - private

- (void)loadAssets {
    NSLog(@"loadAsets");
    if (NSClassFromString(@"PHAsset")) {
    
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    [self performLoadAssets];
                }
            }];
        } else if (status == PHAuthorizationStatusAuthorized) {
            [self performLoadAssets];
        }
    } else {
        [self performLoadAssets];
    }
}

- (void)performLoadAssets {

    NSLog(@"performLoadAssets");
    [self.assets removeAllObjects];
    if (NSClassFromString(@"PHAsset")) {
        // Photos library iOS >= 8
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            PHFetchOptions *options = [PHFetchOptions new];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            PHFetchResult *fetchResults = [PHAsset fetchAssetsWithOptions:options];
            [fetchResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self.assets addObject:obj];
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.block) {
                    self.block(self.assets);
                }
            });
        });
    }
}

#pragma mark - getter/setter
- (NSMutableArray *)assets {

    if (!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}

@end
