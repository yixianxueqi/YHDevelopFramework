//
//  YHFileAction.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/30.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHFileAction.h"

@interface YHFileAction ()

@property (nonatomic,strong) NSFileManager *fileManager;

@end

@implementation YHFileAction

static YHFileAction *fileAction;
+ (instancetype)defaultAction {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileAction = [[self alloc] init];
        fileAction.fileManager = [NSFileManager defaultManager];
    });
    return fileAction;
}
//文件是否存在，若不存在，则创建并返回结果，若存在则返回YES
- (BOOL)fileIsExistAtPath:(NSString *)path {

    BOOL flag = [self.fileManager fileExistsAtPath:path];
    if (flag) {
        return flag;
    } else {
        //不存在
        return [self.fileManager createFileAtPath:path contents:nil attributes:nil];
    }
}
//文件夹是否存在，若不存在，则创建并返回结果，若存在则返回YES
- (BOOL)directoryIsExistAtPath:(NSString *)path {
    
    BOOL isDir;
    BOOL flag = [self.fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (!(isDir && !flag)) {
        //文件夹不存在
        return [self.fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        return YES;
    }
}
/**
 *  计算文件大小
 *
 *  @param path 要计算大小的文件路径
 *
 *  @return 大小单位 B
 */
- (double)fileSizeAtPath:(NSString *)path {

    if ([self.fileManager fileExistsAtPath:path]) {
        long long size = [self.fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
    }
    return 0;
}

/**
 *  计算目录大小
 *
 *  @param path 要计算大小的目录路径
 *
 *  @return 大小单位 B
 */
- (double)folderSizeAtPath:(NSString *)path {

    double size = 0;
    NSArray *pathList = [self filePathWithPath:path];
    for (NSString *path in pathList) {
        size += [self fileSizeAtPath:path];
    }
    return size;
}

/**
 *  删除该目录下的文件
 *
 *  @param path 需要删除文件的文件夹路径
 */
- (void)clearDirectory:(NSString *)path {
    
    NSArray *pathList = [self filePathWithPath:path];
    for (NSString *path in pathList) {
        [self clearFile:path];
    }
}
/**
 *  删除文件
 *
 *  @param path 需要删除文件的文件夹路径
 */
- (void)clearFile:(NSString *)path {

    if ([self.fileManager fileExistsAtPath:path]) {
        [self.fileManager removeItemAtPath:path error:nil];
    }
}

/**
 *  遍历目录中所有文件名字
 *
 *  @param path 需要遍历的文件
 *
 *  @return 文件名字数组
 */
- (NSArray *)fileNameWithPath:(NSString *)path {

    NSMutableArray *list = [NSMutableArray array];
    if ([self.fileManager fileExistsAtPath:path]) {
        NSArray *subFilePath = [self.fileManager subpathsAtPath:path];
        for (NSString *fileName in subFilePath) {
            [list addObject:fileName];
        }
    }
    return list;
}

/**
 *  遍历目录中所有文件路径
 *
 *  @param path 需要遍历的文件
 *
 *  @return 文件路径数组
 */
- (NSArray *)filePathWithPath:(NSString *)path {
    
    NSMutableArray *pathList = [NSMutableArray array];
    NSArray *nameList = [self fileNameWithPath:path];
    for (NSString *name in nameList) {
        [pathList addObject:[path stringByAppendingPathComponent:name]];
    }
    return pathList;
}
@end
