//
//  YHNetCache.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

//缓存名字
#define cacheName @"YHNetworkCache"
/**
 * @class  YHNetCache
 *
 * @abstract 网络缓存
 *
 */
@interface YHNetCache : NSObject

+ (instancetype)sharedCache;

//是否包含该缓存
- (BOOL)containsObjectForKey:(NSString *)key;
//获取该缓存
- (id)objectForKey:(NSString *)key;
//设置该缓存
- (void)setObject:(id)obj forKey:(NSString *)key;
//移除该缓存
- (void)removeObjectforKey:(NSString *)key;
//移除所有缓存
- (void)removeAllObjects;

@end
