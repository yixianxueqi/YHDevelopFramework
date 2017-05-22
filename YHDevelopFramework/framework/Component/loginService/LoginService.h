//
//  LoginService.h
//  testLoginService
//
//  Created by 君若见故 on 17/2/10.
//  Copyright © 2017年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginService : NSObject

+ (instancetype)defaultManager;
- (instancetype)init __attribute__((unavailable("请使用默认单例")));

- (void)saveLoginInfo:(NSDictionary *)info loginResult:(NSDictionary *)result;
- (NSDictionary *)getcurrentLoginInfo;
//0 is all,order by update time
- (NSArray *)getHistoryListCount:(NSInteger)count;
- (void)replaceLoginState;
- (void)clear;

@end
