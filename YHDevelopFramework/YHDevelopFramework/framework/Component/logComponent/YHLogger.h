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

#ifdef DEBUG
 static const int ddLogLevel = DDLogLevelVerbose;
#else
 static const int ddLogLevel = DDLogLevelInfo;
#endif
/**
 * @class  YHLogger
 *
 * @abstract 日志组件
 * @notice 该日志组件是基于CocoaLumberjack
 *
 */
@interface YHLogger : NSObject
/**
 *  初始化log组件
 */
+ (void)defaultLog;
/**
 *  设置日志格式
 */
+ (void)setLogFormat:(id<DDLogFormatter>)format;
/**
 *  设置写入文件的日志等级
 *
 *  @param level DDLogLevel
 */
+ (void)setFileLogLevel:(DDLogLevel)level;

@end
