//
//  FileHelper.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHFileHelper.h"

@implementation YHFileHelper


//获取路径文件的大小
+ (double)fileSize:(NSString *)filePath {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        return 0.f;
    }
    long long size = [manager attributesOfItemAtPath:filePath error:nil].fileSize;
    return size;
}
//获取文件创建日期
+ (NSDate *)fileCreateTime:(NSString *)filePath {

    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        return nil;
    }
    NSDate *date = [manager attributesOfItemAtPath:filePath error:nil].fileCreationDate;
    return date;
}
//获取文件修改日期
+ (NSDate *)fileModifyTime:(NSString *)filePath {

    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        return nil;
    }
    NSDate *date = [manager attributesOfItemAtPath:filePath error:nil].fileModificationDate;
    return date;
}
//文件是否存在，若不存在，则创建并返回结果，若存在则返回YES
+ (BOOL)fileIsExistAtPath:(NSString *)path {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL flag = [manager fileExistsAtPath:path];
    if (flag) {
        return flag;
    } else {
        //不存在
        return [manager createFileAtPath:path contents:nil attributes:nil];
    }
}
//文件夹是否存在，若不存在，则创建并返回结果，若存在则返回YES
+ (BOOL)directoryIsExistAtPath:(NSString *)path {
    
    BOOL isDir;
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL flag = [manager fileExistsAtPath:path isDirectory:&isDir];
    if (!(isDir && !flag)) {
        //文件夹不存在
        return [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        return YES;
    }
}

@end
