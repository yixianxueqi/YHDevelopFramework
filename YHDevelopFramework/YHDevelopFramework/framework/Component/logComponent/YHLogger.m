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

//初始化日志组件
+ (void)defaultLog {

    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    
}
//设置日志格式
+ (void)setLogFormat:(id<DDLogFormatter>)format {

    for (DDAbstractLogger *log in [DDLog allLoggers]) {
        [log setLogFormatter:format];
    }
}

//
+ (void)setFileLogLevel:(DDLogLevel)level {
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7; //日志最多保存7天
    //默认将info等级的写入文件
    [DDLog addLogger:fileLogger withLevel:DDLogLevelInfo];
}

@end
