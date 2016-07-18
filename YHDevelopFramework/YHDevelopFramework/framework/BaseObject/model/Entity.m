//
//  Entity.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/18.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "Entity.h"

@implementation Entity

//自定义映射关系，避免关键字
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id",@"describe":@"description"};
}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [self modelEncodeWithCoder:aCoder];
}
//解档
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}
//复制
- (id)copyWithZone:(NSZone *)zone {
    
    return [self modelCopy];
}
//哈希
- (NSUInteger)hash {
    
    return [self modelHash];
}
//比较
- (BOOL)isEqual:(id)object {
    return [self modelIsEqual:object];
}
//描述
- (NSString *)description {
    
    return [self modelDescription];
}

//+ yy_modelWithJSON  将JSON转化为Model
//+ yy_modelWithDictionary  将字典转化为Model
//- yy_modelToJSONObject    将模型转为键值对
//- yy_modelToJSONString    将模型转为JSON字符串

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
//+ (NSDictionary *)modelContainerPropertyGenericClass {
// value should be Class or Class name.
//    return @{@"books" : @"YYBook" };
//}
// 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
//+ (NSArray *)modelPropertyBlacklist {
//    return @[@"books", @"age"];
//}
// 如果实现了该方法，则处理过程中不会处理该列表外的属性。
//+ (NSArray *)modelPropertyWhitelist {
//    return @[@"userName"];
//}


@end
