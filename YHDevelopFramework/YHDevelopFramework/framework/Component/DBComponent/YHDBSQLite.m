//
//  YHDBSQLite.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/20.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHDBSQLite.h"

@interface YHDBSQLite ()

@property (nonatomic,strong) FMDatabaseQueue *dbQueue;

@end

@implementation YHDBSQLite

static YHDBSQLite *dbManager;

+ (instancetype)sharedDBManagerwWithFile:(NSString *)path {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[self alloc] init];
        dbManager.dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    });
    return dbManager;
}
#pragma mark - define
//在数据库中操作
- (void)doInDataBase:(void (^)(FMDatabase *db))block {

    [dbManager.dbQueue inDatabase:block];
}
//在事务中操作
- (void)doInTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block {

    [dbManager.dbQueue inTransaction:block];
}
//关闭
- (void)close {
    [dbManager.dbQueue close];
}
#pragma mark - private



@end
