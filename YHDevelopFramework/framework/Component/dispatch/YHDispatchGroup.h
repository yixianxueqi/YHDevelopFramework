//
//  YHDispatchGroup.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/23.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DispatchGroupTask)(void);

@interface YHDispatchGroup : NSObject

- (YHDispatchGroup *)doTask:(nonnull DispatchGroupTask)task;
- (void)finallTask:(nonnull DispatchGroupTask)task;

@end
