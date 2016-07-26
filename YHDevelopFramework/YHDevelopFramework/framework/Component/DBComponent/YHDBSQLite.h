//
//  YHDBSQLite.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/20.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

/*
    为确保多线程安全，数据库操作均是在在队列进行，
*/
//数据库路径
#define dbPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:@"db"]
//数据库名字
#define dbName [NSString stringWithFormat:@"%@_DB.db",[[NSBundle mainBundle] bundleIdentifier]]
/**
 * @class  YHDBSQLite
 *
 * @abstract 数据库入口类
 *
 */
@interface YHDBSQLite : NSObject

/**
 *  默认数据库队列管理对象
 *
 *  @return obj
 */
+ (instancetype)sharedDBManagerWithFile:(NSString *)path;
//根据名字创建数据库
- (void)creatDBFileWithName:(NSString *)name;
//在数据库中直接操作
- (void)doInDataBase:(void (^)(FMDatabase *db))block;
//在数据库中以事务操作
- (void)doInTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;
//关闭
- (void)close;
@end
