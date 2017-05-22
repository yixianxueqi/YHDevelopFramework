//
//  YHCrashCatch.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/14.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol YHCrashHandle <NSObject>

@optional
/**
 *  当捕获到一个新的异常时调用
 *
 *  @param detailCrash 异常原因
 */
- (void)crashHandleCatchOneNewCrash:(NSString *)crashDetailInfo;

@end
/**
 * @class YHCrashCatch
 *
 * @abstract 捕获崩溃信息
 *
 */
@interface YHCrashCatch : NSObject
//异常处理代理
@property (nonatomic,weak) id<YHCrashHandle> delegate;
/**
 *  捕获崩溃默认对象
 *
 *  @notice 不建议创建多个实例，建议使用默认
 *  @return YHCrashCatch *obj
 */
+ (instancetype)defaultCrashCatch;
/**
 *  启动获取崩溃信息
 */
- (void)catchCrash;

@end
