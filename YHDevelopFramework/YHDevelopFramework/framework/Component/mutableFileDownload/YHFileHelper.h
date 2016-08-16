//
//  FileHelper.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @class  FileHelper
 *
 * @abstract 文件下载的文件管理帮助对象
 *
 */
@interface YHFileHelper : NSObject

//获取路径文件的大小
+ (double)fileSize:(NSString *)filePath;
//获取文件创建日期
+ (NSDate *)fileCreateTime:(NSString *)filePath;
//获取文件修改日期
+ (NSDate *)fileModifyTime:(NSString *)filePath;
//文件是否存在，若不存在，则创建并返回结果，若存在则返回YES
+ (BOOL)fileIsExistAtPath:(NSString *)path;
//文件夹是否存在，若不存在，则创建并返回结果，若存在则返回YES
+ (BOOL)directoryIsExistAtPath:(NSString *)path;
@end
