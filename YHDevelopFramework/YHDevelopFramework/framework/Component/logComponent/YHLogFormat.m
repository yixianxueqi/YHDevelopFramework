//
//  YHLogFormat.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/12.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHLogFormat.h"

@implementation YHLogFormat

#pragma mark - DDLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    
    {
        NSString *loglevel = nil;
        switch (logMessage.flag)
        {
            case DDLogFlagError:
            {
                loglevel = @"[ERROR]->";
            }
                break;
            case DDLogFlagWarning:
            {
                loglevel = @"[WARN]->";
            }
                break;
            case DDLogFlagInfo:
            {
                loglevel = @"[INFO]->";
            }
                break;
            case DDLogFlagDebug:
            {
                loglevel = @"[DEBUG]->";
            }
                break;
            case DDLogFlagVerbose:
            {
                loglevel = @"[VBOSE]->";
            }
                break;
                
            default:loglevel = @"?";
                break;
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
        
        NSString *formatStr = [NSString stringWithFormat:@"%@ %@: %@ %@ (%ld): %@",[formatter stringFromDate:logMessage->_timestamp], loglevel, logMessage->_fileName, logMessage->_function,logMessage->_line, logMessage->_message];
        return formatStr;
    }
}

@end
