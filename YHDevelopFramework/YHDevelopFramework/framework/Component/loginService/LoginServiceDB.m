//
//  LoginServiceDB.m
//  testLoginService
//
//  Created by 君若见故 on 17/2/10.
//  Copyright © 2017年 isoftstone. All rights reserved.
//

#import "LoginServiceDB.h"
#import <FMDB/FMDB.h>

/*
    数据库表结构：
    列               类型          说明
 ——————————————————————————————————————————————
    id:             integer       主键，自增长
    loginInfo:      text          登录信息
    loginResult:    text          登陆成功返回结果信息
    loginFlag:      string        登录标识
    loginDate:      string        更新日期
 */

static NSString *const dbName = @"loginDB.db";
static NSString *const tableName = @"loginTable";
static NSString *const loginInfo = @"loginInfo";
static NSString *const loginResult = @"loginResult";
static NSString *const loginFlag = @"loginFlag";
static NSString *const loginDate = @"loginDate";

@interface LoginServiceDB ()

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

@implementation LoginServiceDB

- (instancetype)init {

    self = [super init];
    if (self) {
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:[[self class] getCompleteDBName]];
        [self createDBTable];
    }
    return self;
}

#pragma mark - query
- (NSArray *)getrRecentList:(NSInteger)count {
    
    NSMutableArray *list = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            NSLog(@"db open error");
            return ;
        }
        NSString *query;
        if (count == 0) {
            query = [NSString stringWithFormat:@"select * from %@ order by %@ DESC",tableName,loginDate];
        } else {
            query = [NSString stringWithFormat:@"select * from %@ order by %@ DESC limit %@",tableName,loginDate,@(count)];
        }
        FMResultSet *resultSet = [db executeQuery:query];
        while ([resultSet next]) {
            NSDictionary *dic = @{loginInfo:[resultSet stringForColumn:loginInfo],
                                  loginResult: [resultSet stringForColumn:loginResult]};
            [list addObject:dic];
        }
    }];
    return list;
}
- (NSDictionary *)getCurrentLoginInfo {
    
    __block NSDictionary *dic;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            NSLog(@"db open error");
            return ;
        }
        NSString *querySql = [NSString stringWithFormat:@"select * from %@ where %@ = \'%@\'",tableName,loginFlag, @"1"];
        FMResultSet *resultSet = [db executeQuery:querySql];
        while ([resultSet next]) {
            dic = @{loginInfo:[resultSet stringForColumn:loginInfo],
                    loginResult: [resultSet stringForColumn:loginResult]};
        }
    }];
    return dic;
}
#pragma mark - delete
- (void)clear {
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            NSLog(@"db open error");
            return ;
        }
        NSString *deleteAllSql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
        BOOL result = [db executeUpdate:deleteAllSql];
        if (result) {
            NSLog(@"clear loginTable success");
        } else {
            NSLog(@"clear loginTable failure");
        }
    }];
}

#pragma mark - update
- (void)saveLoginInfo:(NSString *)info loginResult:(NSString *)result loginFlag:(NSString *)flag loginDate:(NSString *)date {

    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if (![db open]) {
            NSLog(@"db open error");
            return ;
        }
        //先判断是否存在，若存在则更新，不存在则添加
        //无论添加还是更新，需维护登录是否失效标示唯一
        NSString *querySql = [NSString stringWithFormat:@"select * from %@ where %@ = \'%@\'",tableName,loginInfo,info];
        NSString *updateOldState = [NSString stringWithFormat:@"update %@ set %@ = \'%@\' where %@ = \'%@\'",tableName, loginFlag, @"0", loginFlag, @"1"];
        BOOL resState = [db executeUpdate:updateOldState];
        FMResultSet *resultSet = [db executeQuery:querySql];
        if ([resultSet next]) {
            //更新
            NSString *updateSql = [NSString stringWithFormat:@"update %@ set %@ = \'%@\', %@ = \'%@\', %@ = \'%@\' where %@ = \'%@\'",tableName, loginResult, result, loginFlag, flag, loginDate, date, loginInfo, info];
            BOOL res = [db executeUpdate:updateSql];
            if (resState && res) {
                NSLog(@"update item success");
            } else {
                *rollback = YES;
                NSLog(@"update item failure");
            }
        } else {
            //增加
            NSString *insertSql = [NSString stringWithFormat:@"insert into %@ (%@, %@, %@, %@) values (?, ?, ?, ?);",tableName,loginInfo,loginResult,loginFlag,loginDate];
            BOOL res2 = [db executeUpdate:insertSql,info,result,flag,date];
            if (resState && res2) {
                NSLog(@"save item success");
            } else {
                NSLog(@"save item failure");
                *rollback = YES;
                return ;
            }
        }
        [resultSet close];
    }];
}

- (void)replaceLoginState {

    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            NSLog(@"db open error");
            return ;
        }
        NSString *updateSql = [NSString stringWithFormat:@"update %@ set %@ = \'%@\' where %@ = \'%@\'",tableName, loginFlag, @"0", loginFlag, @"1"];
        BOOL result = [db executeUpdate:updateSql];
        if (result) {
            NSLog(@"replace login State success");
        } else {
            NSLog(@"replace login State failure");
        }
    }];
}

#pragma mark - create
//获取创建数据库的完整路径
+ (NSString *)getCompleteDBName {

    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *filePath = [path stringByAppendingPathComponent:dbName];
    return filePath;
}
//创建表
- (void)createDBTable {

    NSMutableString *createSql = [NSMutableString string];
    [createSql appendFormat:@"create TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, %@ text, %@ text, %@ string, %@ string);",tableName,loginInfo,loginResult,loginFlag,loginDate];

    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            NSLog(@"db open error");
            return ;
        }
       BOOL result = [db executeUpdate:createSql];
       if (result) {
           NSLog(@"create dbTable success");
       } else {
           NSLog(@"create dbTable failure");
       }
    }];
}

@end














