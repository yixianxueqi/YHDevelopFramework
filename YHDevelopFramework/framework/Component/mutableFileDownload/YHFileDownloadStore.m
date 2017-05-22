//
//  YHFileDownloadStore.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/11.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHFileDownloadStore.h"

//数据库名字
#define kFileDownlodDBName @"YHFileDownLoad.db"
//表名
#define kFileDownloadDBTableName @"YHFileDownloadStore"

@interface YHFileDownloadStore ()

@property (nonatomic,strong) YTKKeyValueStore *kvStore;

@end

@implementation YHFileDownloadStore

#pragma mark - life cycle
static YHFileDownloadStore *store;
+ (instancetype)sharedStore {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[self alloc] init];
    });
    return store;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.kvStore = [[YTKKeyValueStore alloc] initDBWithName:kFileDownlodDBName];
        [self.kvStore createTableWithName:kFileDownloadDBTableName];
    }
    return self;
}

#pragma mark - define
- (void)putObjct:(YHFileDownLoadModel *)obj {
    NSDictionary *dic = [obj modelToJSONObject];
    [self.kvStore putObject:dic withId:obj.sigleID intoTable:kFileDownloadDBTableName];
}
- (YHFileDownLoadModel *)getObjctforKey:(NSString *)key {
    id obj = [self.kvStore getObjectById:key fromTable:kFileDownloadDBTableName];
    return [YHFileDownLoadModel modelWithJSON:obj];
}
- (void)deleteObjctForKey:(NSString *)key {
    [self.kvStore deleteObjectById:key fromTable:kFileDownloadDBTableName];
}
- (NSArray<YHFileDownLoadModel *> *)showAllObject {
    NSArray *list = [self.kvStore getAllItemsFromTable:kFileDownloadDBTableName];
    NSMutableArray *listM = [NSMutableArray array];
    for (YTKKeyValueItem *item in list) {
        id obj = item.itemObject;
        YHFileDownLoadModel *model = [YHFileDownLoadModel modelWithJSON:obj];
        [listM addObject:model];
    }
    return listM;
}

@end
