//
//  YHFileCompress.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/30.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @class  YHFileCompress
 *
 * @abstract 文件压缩解压管理
 *
 */
@interface YHFileCompress : NSObject

/**
 *  压缩指定文件夹内的所有文件
 *
 *  @param path      需要压缩的文件夹路径
 *  @param toPath    输出目录
 *  @param fileName  输出文件名称（不需要带后缀，执行完成后会自动加上.zip后缀）
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)zipArchiveFolderWithPath:(NSString *)path toPath:(NSString *)toPath fileName:(NSString *)fileName pwd:(NSString *)pwdString;

/**
 *  压缩指定的多个文件
 *
 *  @param pathArr   文件路径数组
 *  @param toPath    输出目录
 *  @param fileName  输出文件名称（不需要带后缀，执行完成后会自动加上.zip后缀）
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)zipArchiveFilesWithPathArr:(NSArray *)pathArr toPath:(NSString *)toPath fileName:(NSString *)fileName pwd:(NSString *)pwdString;

/**
 *  压缩指定的单个文件
 *
 *  @param path      文件路径
 *  @param toPath    输出目录
 *  @param fileName  输出文件名称（不需要带后缀，执行完成后会自动加上.zip后缀）
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)zipArchiveFileWithPath:(NSString *)path toPath:(NSString *)toPath fileName:(NSString *)fileName pwd:(NSString *)pwdString;
/**
 *  解压缩zip文件
 *
 *  @param path      需要解压的zip文件路径
 *  @param toPath    输出目录
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)unzipOpenFileWithPath:(NSString *)path toPath:(NSString *)toPath pwd:(NSString *)pwdString;
@end
