//
//  BaseService.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHLogger.h"
#import "YHTools.h"
//成功回调
typedef void(^successBlock)(id resp);
//失败回调
typedef void(^failureBlock)(NSInteger errCode, NSString *errMsg);
/**
 * @class  BaseService
 *
 * @abstract 业务基类
 *
 */
@interface BaseService : NSObject


@end
