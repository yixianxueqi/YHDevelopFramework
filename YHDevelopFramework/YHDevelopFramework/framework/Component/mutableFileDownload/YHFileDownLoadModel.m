//
//  FileDownLoadModel.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHFileDownLoadModel.h"
#import "NSString+Secret.h"

@implementation YHFileDownLoadModel

//创建一个新任务
+ (instancetype)modelWithUrl:(NSString *)url filePath:(NSString *)filePath {

    YHFileDownLoadModel *model = [[self alloc] init];
    model.url = url;
    model.filePath = filePath;
    model.name = url.lastPathComponent;
    model.sigleID = [[NSString stringWithFormat:@"%@%@%@",url,filePath,[self getCurrentDateStamp]] md5];
    model.absolutePath = [filePath stringByAppendingPathComponent:url.lastPathComponent];
    return model;
}
//获取当前时间戳
+ (NSString *)getCurrentDateStamp {

    return [NSString stringWithFormat:@"%ld",(long)([[NSDate date] timeIntervalSince1970] * 1000)];
}

@end
