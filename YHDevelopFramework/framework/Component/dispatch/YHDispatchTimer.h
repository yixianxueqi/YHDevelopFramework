//
//  YHDispatchTimer.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/23.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TimerIncident)(void);

@interface YHDispatchTimer : NSObject

- (void)setTimer:(NSTimeInterval)time isMainThread:(BOOL)isMain incident:(nonnull TimerIncident)incident;
- (void)cancelTimer:(nullable TimerIncident)incident;

@end
