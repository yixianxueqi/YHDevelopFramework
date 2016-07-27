//
//  Entity.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/18.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit/NSObject+YYModel.h>
#import "YHLogger.h"
#import "YHTools.h"
/**
 * @class  Entity
 *
 * @abstract 实体基类
 *
 */
@interface Entity : NSObject<NSCoding,NSCopying>

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *describe;

@end
