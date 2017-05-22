//
//  NSNumber+formatter.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/27.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @class  NSNumber (formatter)
 *
 * @abstract 数值格式化
 *
 */
@interface NSNumber (Formatter)

//金钱格式化
- (NSString *)moneyFormatter;
//科学计数法 121212.12 to 12.12E+04
- (NSString *)scienceFormatter;
//百分数
- (NSString *)percentageFormatter;

@end
