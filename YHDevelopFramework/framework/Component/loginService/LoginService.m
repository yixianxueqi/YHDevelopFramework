//
//  LoginService.m
//  testLoginService
//
//  Created by 君若见故 on 17/2/10.
//  Copyright © 2017年 isoftstone. All rights reserved.
//

#import "LoginService.h"
#import "LoginServiceDB.h"

@interface LoginService ()

@property (nonatomic, strong) LoginServiceDB *dbManager;

@end

@implementation LoginService

static LoginService *service;
+(instancetype)defaultManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[self alloc] init];
        service.dbManager = [[LoginServiceDB alloc] init];
    });
    return service;
}

#pragma mark - business
- (void)saveLoginInfo:(NSDictionary *)info loginResult:(NSDictionary *)result {
    
    [self.dbManager saveLoginInfo:[[self class] dicToJson:info] loginResult:[[self class] dicToJson:result] loginFlag:@"1" loginDate:[[self class] getDateStamp]];
}

- (NSDictionary *)getcurrentLoginInfo {

    NSDictionary *dic = [self.dbManager getCurrentLoginInfo];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    for (NSString *key in [dict allKeys]) {
        [dict setValue:[[self class] jsonToDic:dict[key]] forKey:key];
    }
    return dict;
}

- (NSArray *)getHistoryListCount:(NSInteger)count {

    NSArray *list = [self.dbManager getrRecentList:count];
    NSMutableArray *historyList = [NSMutableArray array];
    for (NSDictionary *dic in list) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
        for (NSString *key in [dict allKeys]) {
            [dict setValue:[[self class] jsonToDic:dict[key]] forKey:key];
        }
        [historyList addObject:dict];
    }
    return historyList;
}
- (void)replaceLoginState {

    [self.dbManager replaceLoginState];
}

- (void)clear {

    [self.dbManager clear];
}
#pragma mark - private

+ (NSString *)getDateStamp {
    
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
}

+ (NSString *)dicToJson:(NSDictionary *)dic {
    
    if (!dic || [[dic allKeys] count] == 0) {
        return @"";
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:(4)];
}

+ (NSDictionary *)jsonToDic:(NSString *)jsonStr {

    if (!jsonStr || jsonStr.length == 0) {
        return @{};
    }
    NSDictionary *dic;
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dic;
}

@end
