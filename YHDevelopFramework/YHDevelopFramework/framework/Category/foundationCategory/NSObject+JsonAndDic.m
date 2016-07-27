//
//  NSObject+JsonAndDic.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/27.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NSObject+JsonAndDic.h"
#import <objc/runtime.h>

@implementation NSObject (JsonAndDic)

//将对象转化为json
- (id)toJsonString {
    
    if (![NSJSONSerialization isValidJSONObject:self]) {
        return nil;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
    return jsonString;
}
//将对象转化为Dic
- (id)toDic {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        id value = nil;
        
        @try {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            value = [self getObjectInternal:[self valueForKey:propName]];
            if(value != nil) {
                [dic setObject:value forKey:propName];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
    }
    return dic;
    return nil;
}

- (id)getObjectInternal:(id)obj{
    if(!obj
       || [obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++) {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self toDic];
}

@end
