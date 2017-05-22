//
//  YHDBYTKValueStore.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHDBYTKValueStore.h"

@interface YHDBYTKValueStore ()

@property (nonatomic,strong) YTKKeyValueStore *store;

@end

@implementation YHDBYTKValueStore

static YHDBYTKValueStore *dbKV = nil;
+ (instancetype)sharedDBManagerWithFile:(NSString *)path {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbKV = [[self alloc] init];
        dbKV.store = [[YTKKeyValueStore alloc] initWithDBWithPath:path];
    });
    return dbKV;
}
#pragma mark - define
//创建表
- (void)createTableWithName:(NSString *)tableName {
    [self.store createTableWithName:tableName];
}
//清理表内所有数据
- (void)clearTable:(NSString *)tableName {
    [self.store clearTable:tableName];
}
//关闭数据库
- (void)close {
    [self.store close];
}
//存入对象
- (NSString *)putObject:(id)object intoTable:(NSString *)tableName {
    
    if ([NSJSONSerialization isValidJSONObject:object]) {
        NSString *keyID = [self getcurrentDateStamp];
        [self.store putObject:object withId:keyID intoTable:tableName];
        return keyID;
    } else {
        return nil;
    }
}
//取出对象
- (YTKKeyValueItem *)getYTKKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName {
    
    YTKKeyValueItem *item = [self.store getYTKKeyValueItemById:objectId fromTable:tableName];
    return item;
}
//存入字符串
- (NSString *)putString:(NSString *)string intoTable:(NSString *)tableName {

    NSString *keyID = [self getcurrentDateStamp];
    [self.store putString:string withId:keyID intoTable:tableName];
    return keyID;
}
//取出字符串
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName {

    return [self.store getStringById:stringId fromTable:tableName];
}
//存入数值对象
- (NSString *)putNumber:(NSNumber *)number intoTable:(NSString *)tableName {
    
    NSString *keyID = [self getcurrentDateStamp];
    [self.store putNumber:number withId:keyID intoTable:tableName];
    return keyID;
}
//取出数值对象
- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName {
    
    return [self.store getNumberById:numberId fromTable:tableName];
}
//获取表内所有对象
- (NSArray *)getAllItemsFromTable:(NSString *)tableName {
    
    return [self.store getAllItemsFromTable:tableName];
}
//删除对象
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName {
    
    [self.store deleteObjectById:objectId fromTable:tableName];
}
//删除数组内指定对象
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName {
    
    [self.store deleteObjectsByIdArray:objectIdArray fromTable:tableName];
}
#pragma mark - private

- (NSString *)getcurrentDateStamp {

    return [NSString stringWithFormat:@"%ld",(long)([[NSDate date] timeIntervalSince1970] * 1000)];
}

@end
