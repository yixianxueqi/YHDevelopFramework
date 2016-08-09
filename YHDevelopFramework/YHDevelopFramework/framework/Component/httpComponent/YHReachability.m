//
//  YHReachability.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/5.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHReachability.h"

@interface YHReachability ()

@property (nonatomic,strong) AFNetworkReachabilityManager *manager;

@end

@implementation YHReachability

static YHReachability *reach;
+ (instancetype)sharedManager {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reach = [[self alloc] init];
    });
    return reach;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [AFNetworkReachabilityManager sharedManager];
    }
    return self;
}

- (AFNetworkReachabilityStatus)getCurrentStatus {

    return self.manager.networkReachabilityStatus;
}
- (BOOL)reachable {
    
    return self.manager.reachable;
}
- (void)beginObserveNetWithResult:(void (^)(AFNetworkReachabilityStatus))block {

    [self.manager setReachabilityStatusChangeBlock:block];
    [self.manager startMonitoring];
}

- (void)dealloc {

    [self.manager stopMonitoring];
}

@end
