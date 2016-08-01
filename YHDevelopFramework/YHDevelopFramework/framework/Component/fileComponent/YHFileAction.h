//
//  YHFileAction.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/30.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @class  YHFileAction
 *
 * @abstract 文件实际操作执行者
 *
 */
@interface YHFileAction : NSObject

+ (instancetype)defaultAction;

//文件是否存在，若不存在，则创建并返回结果，若存在则返回YES
- (BOOL)fileIsExistAtPath:(NSString *)path;
//文件夹是否存在，若不存在，则创建并返回结果，若存在则返回YES
- (BOOL)directoryIsExistAtPath:(NSString *)path;
/**
 *  计算文件大小
 *
 *  @param path 要计算大小的文件路径
 *
 *  @return 大小单位 B
 */
- (double)fileSizeAtPath:(NSString *)path;

/**
 *  计算目录大小
 *
 *  @param path 要计算大小的目录路径
 *
 *  @return 大小单位 B
 */
- (double)folderSizeAtPath:(NSString *)path;

/**
 *  删除该目录下的文件
 *
 *  @param path 需要删除文件的文件夹路径
 */
- (void)clearDirectory:(NSString *)path;
/**
 *  删除文件
 *
 *  @param path 需要删除文件的文件夹路径
 */
- (void)clearFile:(NSString *)path;
/**
 *  遍历目录中所有文件名字
 *
 *  @param path 需要遍历的文件
 *
 *  @return 文件名字数组
 */
- (NSArray *)fileNameWithPath:(NSString *)path;

/**
 *  遍历目录中所有文件路径
 *
 *  @param path 需要遍历的文件
 *
 *  @return 文件路径数组
 */
- (NSArray *)filePathWithPath:(NSString *)path;

@end
