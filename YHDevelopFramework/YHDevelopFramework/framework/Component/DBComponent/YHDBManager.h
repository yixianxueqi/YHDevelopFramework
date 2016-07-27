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
//fmdb数据库管理对象
- (YHDBSQLite *)getdbSqlite;
#pragma mark - YTKKeyValueStore
//YTKKeyValueStore数据库岸管理对象
- (YHDBYTKValueStore *)getKeyValueStore;

@end
