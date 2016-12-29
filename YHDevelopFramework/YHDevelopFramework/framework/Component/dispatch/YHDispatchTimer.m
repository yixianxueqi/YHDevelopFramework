//
//  YHDispatchTimer.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/23.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHDispatchTimer.h"

@interface YHDispatchTimer ()

@property (nonatomic,strong) dispatch_queue_t queue;
@property (nonatomic,strong) dispatch_source_t timer;

@end

@implementation YHDispatchTimer

- (void)setTimer:(NSTimeInterval)time isMainThread:(BOOL)isMain incident:(nonnull TimerIncident)incident {

    if (isMain) {
        self.queue = dispatch_get_main_queue();
    } else {
        self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, time * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        incident();
    });
    dispatch_resume(self.timer);
}

- (void)cancelTimer:(nullable TimerIncident)incident {

    dispatch_source_set_cancel_handler(self.timer, ^{
        if (incident) {
            incident();
        }
    });
    dispatch_cancel(self.timer);
}

@end
