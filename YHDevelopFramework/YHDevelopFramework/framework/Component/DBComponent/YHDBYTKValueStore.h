//
//  YHDBYTKValueStore.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKKeyValueStore/YTKKeyValueStore.h>
/**
 * @class YHDBYTKValueStore
 *
 * @abstract 数据库入口类
 *
 */
@interface YHDBYTKValueStore : NSObject
/**
 *  默认数据库队列管理对象
 *
 *  @param 数据库文件路径
 *  @return obj
 */
+ (instancetype)sharedDBManagerWithFile:(NSString *)path;
//创建表
- (void)createTableWithName:(NSString *)tableName;
//清理表内所有数据
- (void)clearTable:(NSString *)tableName;
//关闭数据库
- (void)close;
//存入对象
- (NSString *)putObject:(id)object intoTable:(NSString *)tableName;
//取出对象
- (YTKKeyValueItem *)getYTKKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;
//存入字符串
- (NSString *)putString:(NSString *)string intoTable:(NSString *)tableName;
//取出字符串
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;
//存入数值对象
- (NSString *)putNumber:(NSNumber *)number intoTable:(NSString *)tableName;
//取出数值对象
- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;
//获取表内所有对象
- (NSArray *)getAllItemsFromTable:(NSString *)tableName;
//删除对象
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
//删除数组内指定对象
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;

@end
