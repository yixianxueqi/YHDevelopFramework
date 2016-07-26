//
//  Person.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/21.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) BOOL sex;
@property (nonatomic,assign) NSUInteger age;
@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong) NSArray *list;

@end
