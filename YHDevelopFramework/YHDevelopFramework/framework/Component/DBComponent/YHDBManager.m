//
//  YHDBManager.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/20.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHDBManager.h"
#import <objc/runtime.h>

//数据库路径
#define dbFilePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:@"db"]
//valueStore数据库名字
#define dbKVName [NSString stringWithFormat:@"%@_kv.db",[[NSBundle mainBundle] bundleIdentifier]]
//fmdb数据库名字
#define dbSQLName [NSString stringWithFormat:@"%@_sql.db",[[NSBundle mainBundle] bundleIdentifier]]

@interface YHDBManager ()

@property (nonatomic,strong) YHDBSQLite *dbSQLite;
@property (nonatomic,strong) YHDBYTKValueStore *dbValueStore;

@end

@implementation YHDBManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        //1.初始化路径
        [self creatFilePath];
        
    }
    return self;
}

#pragma mark - fmdb

- (YHDBSQLite *)getdbSqlite {

    return self.dbSQLite;
}

#pragma mark - YTKKeyValueStore

- (YHDBYTKValueStore *)getKeyValueStore {

    return self.dbValueStore;
}

#pragma mark - private
- (BOOL)creatFilePath {

    //创建数据库所在的文件夹
    BOOL isDir = false;
    BOOL isSuc = NO;
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:dbFilePath isDirectory:&isDir];
    if (!(isDir && !isDirExist)) {
        //目录不存在，则创建目录
        isSuc = [[NSFileManager defaultManager] createDirectoryAtPath:dbFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return isSuc;
}

#pragma mark - getter/setter
- (YHDBSQLite *)dbSQLite {

    if (!_dbSQLite) {
        NSString *filePath = [dbFilePath stringByAppendingPathComponent:dbSQLName];
        _dbSQLite = [YHDBSQLite sharedDBManagerWithFile:filePath];
    }
    return _dbSQLite;
}

- (YHDBYTKValueStore *)dbValueStore {

    if (!_dbValueStore) {
        NSString *filePath = [dbFilePath stringByAppendingPathComponent:dbKVName];
        _dbValueStore = [YHDBYTKValueStore sharedDBManagerWithFile:filePath];
    }
    return _dbValueStore;
}

@end
