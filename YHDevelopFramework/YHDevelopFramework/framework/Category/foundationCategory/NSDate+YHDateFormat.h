//
//  NSDate+YHDateFormat.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//


/*
 该格式可以指定以下内容:
 
 G: 公元时代，例如AD公元
 
 yy: 年的后2位
 
 yyyy: 完整年
 
 MM: 月，显示为1-12
 
 MMM: 月，显示为英文月份简写,如 Jan
 
 MMMM: 月，显示为英文月份全称，如 Janualy
 
 dd: 日，2位数表示，如02
 
 d: 日，1-2位显示，如 2
 
 EEE: 简写星期几，如Sun
 
 EEEE: 全写星期几，如Sunday
 
 aa: 上下午，AM/PM
 
 H: 时，24小时制，0-23
 
 h：时，12小时制，0-11
 
 m: 分，1-2位
 
 mm: 分，2位
 
 s: 秒，1-2位
 
 ss: 秒，2位
 
 S: 毫秒
 */

#import <Foundation/Foundation.h>

@interface YHDate : NSObject

@property (nonatomic,strong) NSString *startDate;
@property (nonatomic,strong) NSString *endDate;

+ (instancetype)getYHDateStartDate:(NSString *)startDate endDate:(NSString *)endDate;

@end

#pragma mark - Category
/**
 * @class  NSDate (YHDateFormat)
 *
 * @abstract 日期获取与转换
 *
 */
@interface NSDate (YHDateFormat)
/**
 *  获取当前时间戳
 *
 *  @return NSString
 */
+ (NSString *)getCurrentDateStamp;
/**
 *  获取指定日期的时间戳
 *
 *  @param date 指定日期
 *
 *  @return NSString
 */
+ (NSString *)getDateStamp:(NSDate *)date;
/**
 *  根据指定日期和格式获取时间
 *
 *  @param date      指定日期
 *  @param formatStr 格式
 *
 *  @return NSString
 */
+ (NSString *)getDateTimeWithDate:(NSDate *)date format:(NSString *)formatStr;
/**
 *  根据指定的时间戳和格式转化为时间
 *
 *  @param dateStamp 时间戳
 *  @param formatStr 格式
 *
 *  @return NSString
 */
+ (NSString *)getDateTimeOfDateStamp:(NSString *)dateStamp format:(NSString *)formatStr;
/**
 *  根据格式字符串返回当前时间
 *
 *  @param formatStr 时间格式
 *
 *  @return NSString
 */
+ (NSString *)getCurrentTimeByFormat:(NSString *)formatStr;
/**
 *  根据日期和格式的起始时间与结束时间戳
 *
 *  @param date 指定日期
 *  @param type 指定格式
 *
 *  @return YHDate
 */
+ (YHDate *)getStartEndDateStampOfDate:(NSDate *)date type:(NSCalendarUnit)type;

@end





