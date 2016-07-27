//
//  NSObject+JsonAndDic.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/27.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JsonAndDic)

//将对象转化为json
- (id)toJsonString;
//将对象转化为Dic
- (id)toDic;

@end
