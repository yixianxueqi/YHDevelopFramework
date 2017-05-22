//
//  NSNumber+formatter.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/27.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NSNumber+formatter.h"

@implementation NSNumber (Formatter)

//金钱格式化
- (NSString *)moneyFormatter {

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:self];
    return formattedNumberString;
}

//科学计数法
- (NSString *)scienceFormatter {

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"00.00E+00"];
    NSString *convertNumber = [formatter stringFromNumber:self];
    return convertNumber;
}
//百分数
- (NSString *)percentageFormatter {

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"0.00%"];
    NSString *convertNumber = [formatter stringFromNumber:self];
    return convertNumber;
}
@end
