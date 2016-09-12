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
#ifndef __OPTIMIZE__
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
#endif
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    logger = [[YHLogger alloc] init];
}

+ (instancetype)getLogger {

    return logger;
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
    fileLogger.logFileManager.maximumNumberOfLogFiles = 4; //日志最多个数4
    [fileLogger setLogFormatter:[[[DDLog allLoggers] firstObject] logFormatter]];
    //默认将info等级的写入文件
    [DDLog addLogger:fileLogger withLevel:level];
    //当日志文件达到限制时，会被抛出
    [fileLogger rollLogFileWithCompletionBlock:^{
        if (logger.delegate && [logger.delegate respondsToSelector:@selector(showAllNormalLogFilePath:)]) {
            [logger.delegate showAllNormalLogFilePath:[logger getAllNormalLog]];
        }
    }];
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
    NSString *filePath = [self createFile:[self fileName] path:[self filePath]];
    [self writeToFile:filePath contents:exceptionInfo];
    if (self.delegate) {
        //调用代理，回调刚刚新建的崩溃日志
        if ([self.delegate respondsToSelector:@selector(oneNewCrashLogFileAvaliable:)]) {
            [self.delegate oneNewCrashLogFileAvaliable:filePath];
        }
        //调用代理，回调所有的崩溃日志
        if ([self.delegate respondsToSelector:@selector(showALLCrashLogFilePath:)]) {
            [self.delegate showALLCrashLogFilePath:[self getAllCrashLog]];
        }
    }
}

#pragma mark - 文件操作
//获取文件名字
- (NSString *)fileName {

    NSString *fileName = nil;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeStamp = [format stringFromDate:[NSDate date]];
    fileName = [NSString stringWithFormat:@"Crash_%@.log",timeStamp];
    return fileName;
    
}
//获取文件路径
- (NSString *)filePath {

    NSString *path = nil;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *logDir = [cachePath stringByAppendingPathComponent:@"Logs"];
    BOOL isDir = false;
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:logDir isDirectory:&isDir];
    if (!(isDir && !isDirExist)) {
        //目录不存在，则创建目录
        NSError *error = nil;
        BOOL isSuc = [[NSFileManager defaultManager] createDirectoryAtPath:logDir withIntermediateDirectories:YES attributes:nil error:&error];
        if (isSuc) {
            //创建目录成功
            path = logDir;
        }
    }
    return path;
}
//创建文件
- (NSString *)createFile:(NSString *)fileName path:(NSString *)path {

    NSString *file;
    if (fileName && path) {
        //名字 && 路径 都存在
        NSString *logFilePath = [path stringByAppendingPathComponent:fileName];
        BOOL fileExist = [[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil];
        if (fileExist) {
            //文件创建成功
            file = logFilePath;
        }
    }
    return file;
}
//向文件内写内容
- (void)writeToFile:(NSString *)filePath contents:(NSString *)content {
    
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    BOOL isSuc = [data writeToFile:filePath atomically:YES];
    if (!isSuc) {
        DDLogError(@"Crash Info write to file failure!");
    }
}
//获取路径下所有崩溃日志文件
- (NSArray *)getAllCrashLog {

    NSMutableArray *list = [NSMutableArray array];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:[self filePath]];
    for (NSString *file in [enumerator allObjects]) {
        if ([file hasPrefix:@"Crash"]) {
            [list addObject:[[self filePath] stringByAppendingPathComponent:file]];
        }
    }
    return list;
}
//获取路径下所有正常日志文件
- (NSArray *)getAllNormalLog {
    
    NSMutableArray *list = [NSMutableArray array];
    NSString *bundelIdentifier = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:[self filePath]];
    for (NSString *file in [enumerator allObjects]) {
        if ([file hasPrefix:bundelIdentifier]) {
            [list addObject:[[self filePath] stringByAppendingPathComponent:file]];
        }
    }
    return list;
}



@end
