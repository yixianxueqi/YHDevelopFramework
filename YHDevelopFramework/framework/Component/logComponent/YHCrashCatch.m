//
//  YHCrashCatch.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/14.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHCrashCatch.h"

@implementation YHCrashCatch

static YHCrashCatch *crashCatch = nil;
+ (instancetype)defaultCrashCatch {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        crashCatch = [[self alloc] init];
    });
    return crashCatch;
}
/**
 *  启动获取崩溃信息
 */
- (void)catchCrash {

    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}
//获取异常信息
void uncaughtExceptionHandler(NSException *exception){
    
    //异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    //异常原因
    NSString *reason = [exception reason];
    //异常名称
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    //调用代理处理异常
    if (crashCatch.delegate && [crashCatch.delegate respondsToSelector:@selector(crashHandleCatchOneNewCrash:)]) {
        [crashCatch.delegate crashHandleCatchOneNewCrash:exceptionInfo];
    }
}


@end
