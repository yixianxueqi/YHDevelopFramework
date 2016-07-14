//
//  YHLogger.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/12.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHLogger.h"

@interface YHLogger ()

@end

@implementation YHLogger

static YHLogger *logger = nil;
//初始化日志组件
+ (void)defaultLog {

    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    logger = [[YHLogger alloc] init];
}
//设置日志格式
+ (void)setLogFormat:(id<DDLogFormatter>)format {

    for (DDAbstractLogger *log in [DDLog allLoggers]) {
        [log setLogFormatter:format];
    }
}

//设置写入文件的日志等级,同时将符合等级的日志写入文件内
+ (void)setFileLogLevel:(DDLogLevel)level {
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24 * 7; // 24 hour rolling * 7
    fileLogger.logFileManager.maximumNumberOfLogFiles = 12; //日志最多个数12
    [fileLogger setLogFormatter:[[[DDLog allLoggers] firstObject] logFormatter]];
    //默认将info等级的写入文件
    [DDLog addLogger:fileLogger withLevel:level];
}


//开始捕获崩溃信息
+ (void)startCatchCrashInfo {

    [[YHCrashCatch defaultCrashCatch] catchCrash];
    [YHCrashCatch defaultCrashCatch].delegate = logger;
}

#pragma mark - YHCrashHandle

- (void)crashHandleCatchOneNewCrash:(NSString *)crashDetailInfo {

    [self createCrashLogFile:crashDetailInfo];
}

#pragma mark - define

- (void)createCrashLogFile:(NSString *)exceptionInfo {

    //1,将崩溃信息写入文件
    //2,获得目录下的崩溃日志
    if (self.delegate) {
        //调用代理，回调刚刚新建的崩溃日志
        if ([self.delegate respondsToSelector:@selector(oneNewCrashLogFileAvaliable:)]) {
            [self.delegate oneNewCrashLogFileAvaliable:nil];
        }
        //调用代理，回调所有的崩溃日志
        if ([self.delegate respondsToSelector:@selector(showALLCrashLogFilePath:)]) {
            [self.delegate showALLCrashLogFilePath:nil];
        }
    }
}


@end
