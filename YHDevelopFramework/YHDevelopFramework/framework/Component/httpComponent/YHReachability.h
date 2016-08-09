//
//  YHReachability.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/5.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
/**
 * @class  YHReachability
 *
 * @abstract 网络监测
 *
 */
@interface YHReachability : NSObject

+ (instancetype)sharedManager;
- (void)beginObserveNetWithResult:(void (^)(AFNetworkReachabilityStatus status))block;

@end
