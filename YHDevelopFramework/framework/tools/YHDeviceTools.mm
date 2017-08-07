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
#import <ifaddrs.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <mach/mach.h>
#import <objc/runtime.h>

//存入keyChain的标示
static const NSString *key = @"KEY_UUID";

@implementation YHDeviceTools

//获取app名称
+ (NSString *)appName {

    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}
//  获取Bundle Identifier
+ (NSString *)bundleIdentifier {

    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
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
    
    //1.获取uuid，若有则从keychain中获取
    //2.若没有，则创建新的并存入keychain中
    NSString *uuid = [self getUUID];
    if (!uuid) {
        uuid = [self newUUID];
        [self saveUUID:uuid];
    }
    return uuid;
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


// 获取当前设备IP
+ (NSString *)getDeviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) { // 0 表示获取成功
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

/// 获取总内存大小
+ (long long)getTotalMemorySize {
    return [NSProcessInfo processInfo].physicalMemory;
}

/// 获取当前可用内存
+ (long long)getAvailableMemorySize {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

/// 获取精准电池电量
+ (CGFloat)getCurrentBatteryLevel {
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
        Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
        id status  = object_getIvar(app, ivar);
        for (id aview in [status subviews]) {
            int batteryLevel = 0;
            for (id bview in [aview subviews]) {
                if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0) {
                    Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
                    if(ivar) {
                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
                        if (batteryLevel > 0 && batteryLevel <= 100) {
                            return batteryLevel;
                        } else {
                            return 0;
                        }
                    }
                }
            }
        }
    }
    return 0;
}

#pragma mark - private

+ (NSString *)newUUID {

    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    result = [result lowercaseString];
    return result;
}

+ (NSString *)getUUID {

    NSDictionary *dic = [self load:[self bundleIdentifier]];
    return dic[key];
}

+ (void)saveUUID:(NSString *)uuid {

    NSDictionary *dic = @{key:uuid};
    NSString *service = [self bundleIdentifier];
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:dic] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);

}
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
            //
        }
    }
    return ret;
}

@end
