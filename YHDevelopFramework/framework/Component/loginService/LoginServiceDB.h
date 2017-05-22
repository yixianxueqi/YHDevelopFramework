//
//  LoginServiceDB.h
//  testLoginService
//
//  Created by 君若见故 on 17/2/10.
//  Copyright © 2017年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginServiceDB : NSObject

- (void)saveLoginInfo:(NSString *)info loginResult:(NSString *)result loginFlag:(NSString *)flag loginDate:(NSString *)date;
// 0 is all
- (NSArray *)getrRecentList:(NSInteger)count;
- (NSDictionary *)getCurrentLoginInfo;
- (void)replaceLoginState;
- (void)clear;

@end
