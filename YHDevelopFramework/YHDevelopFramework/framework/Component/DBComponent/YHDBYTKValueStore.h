//
//  YHDBYTKValueStore.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKKeyValueStore.h"
/**
 * @class YHDBYTKValueStore
 *
 * @abstract 数据库入口类
 *
 */
@interface YHDBYTKValueStore : NSObject

+ (instancetype)sharedDBManagerWithFile:(NSString *)path;

@end
