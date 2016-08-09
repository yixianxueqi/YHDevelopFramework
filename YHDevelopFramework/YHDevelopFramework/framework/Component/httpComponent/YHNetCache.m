//
//  YHNetCache.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHNetCache.h"
#import <YYCache.h>

@interface YHNetCache ()

@property (nonatomic,strong) YYCache *cache;

@end

@implementation YHNetCache

static YHNetCache *yhCache;
+ (instancetype)sharedCache {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yhCache = [[self alloc] init];
        
        yhCache.cache = [[YYCache alloc] initWithPath:[yhCache cachePath]];
    });
    return yhCache;
}

//是否包含该缓存
- (BOOL)containsObjectForKey:(NSString *)key {

    return [yhCache.cache containsObjectForKey:key];
}
//获取该缓存
- (id)objectForKey:(NSString *)key {
    
    return [yhCache.cache objectForKey:key];
}
//设置该缓存
- (void)setObject:(id)obj forKey:(NSString *)key {

    [yhCache.cache setObject:obj forKey:key];
}
//移除该缓存
- (void)removeObjectforKey:(NSString *)key {

    [yhCache.cache removeObjectForKey:key];
}
//移除所有缓存
- (void)removeAllObjects {

    [yhCache.cache removeAllObjects];
}

#pragma mark - private

- (NSString *)cachePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [cachePath stringByAppendingPathComponent:@"NetworkCache"];
    BOOL isDir;
    BOOL flag = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (!(isDir && !flag)) {
        //文件夹不存在
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [path stringByAppendingPathComponent:cacheName];
}

@end
