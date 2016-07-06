//
//  NSDate+YHDateFormat.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NSDate+YHDateFormat.h"

@implementation YHDate

+ (instancetype)getYHDateStartDate:(NSString *)startDate endDate:(NSString *)endDate {

    YHDate *date = [[self alloc] init];
    date.startDate = startDate;
    date.endDate = endDate;
    return date;
}

@end

@implementation NSDate (YHDateFormat)

//获取当前时间戳
+ (NSString *)getCurrentDateStamp {

    return [self getDateStamp:[NSDate date]];
}

//根据指定时间戳和格式返回时间字符串
+ (NSString *)getDateTimeOfDateStamp:(NSString *)dateStamp format:(NSString *)formatStr {

    NSTimeInterval interval = [dateStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [self getDateTimeWithDate:date format:formatStr];
}

//根据格式字符串返回当前时间
+ (NSString *)getCurrentTimeByFormat:(NSString *)formatStr {

   return [self getDateTimeWithDate:[NSDate date] format:formatStr];
}
//获取指定日期的指定类型的起始时间
+ (YHDate *)getStartEndDateStampOfDate:(NSDate *)date type:(NSCalendarUnit)type {

    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    double interval = 0;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if (type == NSCalendarUnitWeekOfMonth || type == NSCalendarUnitWeekOfYear) {
        //设定周一为首日
        [calendar setFirstWeekday:2];
    }
    BOOL flag = [calendar rangeOfUnit:type startDate:&beginDate interval:&interval forDate:date];
    if (flag) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    } else {
        return  nil;
    }
    YHDate *yhDate = [YHDate getYHDateStartDate:[self getDateStamp:beginDate] endDate:[self getDateStamp:endDate]];
    return yhDate;
}

//获取指定时间的时间戳
+ (NSString *)getDateStamp:(NSDate *)date {
    
   return [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
}
//根据日期和格式返回时间
+ (NSString *)getDateTimeWithDate:(NSDate *)date format:(NSString *)formatStr {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatStr];
    return [formatter stringFromDate:date];
}

@end
