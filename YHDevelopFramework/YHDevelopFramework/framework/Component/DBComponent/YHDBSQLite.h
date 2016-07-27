//
//  YHDBSQLite.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/20.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
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
 *  @param 数据库文件路径
 *  @return obj
 */
+ (instancetype)sharedDBManagerWithFile:(NSString *)path;

@end
