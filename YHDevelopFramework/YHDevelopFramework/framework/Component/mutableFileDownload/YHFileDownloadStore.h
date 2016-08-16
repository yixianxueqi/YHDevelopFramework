//
//  YHFileDownloadStore.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/11.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKKeyValueStore/YTKKeyValueStore.h>
#import "YHFileDownLoadModel.h"
/**
 * @class  YHFileDownloadStore
 *
 * @abstract 文件下载存储
 *
 */
@interface YHFileDownloadStore : NSObject

+ (instancetype)sharedStore;

/*
    此处采用键值存储的方式，key值为唯一标示:sigleID
 */
- (void)putObjct:(YHFileDownLoadModel *)obj;
- (YHFileDownLoadModel *)getObjctforKey:(NSString *)key;
- (void)deleteObjctForKey:(NSString *)key;
- (NSArray<YHFileDownLoadModel *> *)showAllObject;

@end
