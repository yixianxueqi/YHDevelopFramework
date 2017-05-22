//
//  YHDispatchGroup.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/23.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHDispatchGroup.h"

@interface YHDispatchGroup ()

@property (nonatomic,strong) dispatch_queue_t globalQueue;
@property (nonatomic,strong) dispatch_queue_t mainQueue;
@property (nonatomic,strong) dispatch_group_t group;

@end

@implementation YHDispatchGroup

- (instancetype)init
{
    self = [super init];
    if (self) {
        _globalQueue = dispatch_queue_create("com.group.task", DISPATCH_QUEUE_CONCURRENT);
        _mainQueue = dispatch_get_main_queue();
        _group = dispatch_group_create();
    }
    return self;
}

- (YHDispatchGroup *)doTask:(nonnull DispatchGroupTask)task {

    dispatch_group_async(self.group, self.globalQueue, ^{
        task();
    });
    return  self;
}
- (void)finallTask:(nonnull DispatchGroupTask)task {

    dispatch_group_notify(self.group, self.mainQueue, ^{
        task();
    });
}

@end
