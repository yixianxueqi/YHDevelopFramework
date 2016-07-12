//
//  YHDeviceTools.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/12.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHDeviceTools.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation YHDeviceTools

//获取app名称
+ (NSString *)appName {

    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}
//获取app版本
+ (NSString *)appVersion {

    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}
//获取app build版本
+ (NSString *)appBuildVersion {

    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}
//获取设备序列号
+ (NSString *)deviceSerialNum {

    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
//获取设备唯一标识
+ (NSString *)uuid {
    
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    //NSLog(@"uuid %@",result);
    result = [result lowercaseString];
    return result;
}
//获取设备别名
+ (NSString *)deviceNameDefineByUser {

    return [[UIDevice currentDevice] name];
}
//获取设备名称
+ (NSString *)deviceName {
    
    return [[UIDevice currentDevice] systemName];
}
//获取设备系统版本
+ (NSString *)deviceSystemVersion {

    return [[UIDevice currentDevice] systemVersion];
}
//获取设备型号
+ (NSString *)deviceModel {

    return [[UIDevice currentDevice] model];
}
//获取设备区域型号
+ (NSString *)deviceLocalModel {

    return [[UIDevice currentDevice] localizedModel];
}
//获取运营商信息
+ (NSString *)operatorInfo {
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    return [[info subscriberCellularProvider] carrierName];
}
//获取电池状态
+ (UIDeviceBatteryState)batteryState {
    
    return [[UIDevice currentDevice] batteryState];
}
//获取电量等级
+ (CGFloat)batteryLevel {

    return [[UIDevice currentDevice] batteryLevel];
}

@end
