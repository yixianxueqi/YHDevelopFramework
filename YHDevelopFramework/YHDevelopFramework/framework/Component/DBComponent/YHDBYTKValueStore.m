//
//  YHDBYTKValueStore.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHDBYTKValueStore.h"

@interface YHDBYTKValueStore ()

@property (nonatomic,strong) YTKKeyValueStore *store;

@end

@implementation YHDBYTKValueStore

static YHDBYTKValueStore *dbKV = nil;
+ (instancetype)sharedDBManagerWithFile:(NSString *)path {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbKV = [[self alloc] init];
        dbKV.store = [[YTKKeyValueStore alloc] initWithDBWithPath:path];
    });
    return dbKV;
}


@end
