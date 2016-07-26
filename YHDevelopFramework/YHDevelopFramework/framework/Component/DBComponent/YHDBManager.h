//
//  YHDBManager.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/20.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHDBSQLite.h"
#import "YHDBYTKValueStore.h"
/**
 * @class YHDBManager
 *
 * @abstract 数据库管理类
 *
 */
@interface YHDBManager : NSObject

#pragma mark - fmdb

#pragma mark - YTKKeyValueStore
//创建表
- (void)createTableWithName:(NSString *)tableName;
//清理表内所有数据
- (void)clearTable:(NSString *)tableName;
//关闭数据库
- (void)close;
//存入对象
- (YTKKeyValueItem *)putObject:(id)object intoTable:(NSString *)tableName;
//取出对象
- (YTKKeyValueItem *)getYTKKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;
//获取表内所有对象
- (NSArray *)getAllItemsFromTable:(NSString *)tableName;
//删除对象
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
//删除数组内指定对象
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;

@end
