//
//  YHLogger.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/12.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "YHLogFormat.h"
#import "YHCrashCatch.h"


/*
 *  默认调式模式 是DDLogLevelVerbose级别
 *     开发模式 是DDLogLevelInfo级别
 */
#ifdef DEBUG
 static const int ddLogLevel = DDLogLevelVerbose;
#else
 static const int ddLogLevel = DDLogLevelInfo;
#endif

// 日志处理代理
@protocol YHLoggerHandle <NSObject>

@optional
/**
 *  获取所有正常的日志文件路径
 *
 *  @param filePathList 日志路径信息
 */
- (void)showAllNormalLogFilePath:(NSArray *)filePathList;
/**
 *  获取所有崩溃日志的路径信息
 *
 *  @param filePathList 所有崩溃日志的路径信息
 */
- (void)showALLCrashLogFilePath:(NSArray *)filePathList;
/**
 *  当有一个新的崩溃日志可用时
 *
 *  @param filePath 新的崩溃日志的路径
 */
- (void)oneNewCrashLogFileAvaliable:(NSString *)filePath;

@end

/**
 * @class  YHLogger
 *
 * @abstract 日志组件
 * @notice 该日志组件是基于CocoaLumberjack
 *
 */
@interface YHLogger : NSObject<YHCrashHandle>

//崩溃日志处理代理
@property (nonatomic,weak) id<YHLoggerHandle> delegate;
/**
 *  初始化log组件
 */
+ (void)defaultLog;
/**
 *  设置日志格式
 */
+ (void)setLogFormat:(id<DDLogFormatter>)format;
/**
 *  设置写入文件的日志等级,同时将符合等级的日志写入文件内
 *
 *  @param level DDLogLevel
 */
+ (void)setFileLogLevel:(DDLogLevel)level;
/**
 *  开始捕获崩溃信息
 */
+ (void)startCatchCrashInfo;

@end
