//
//  YHFileManager.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/30.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,FileType) {

    FileTypeFile = 1,
    FileTypeDirectory,
};
/**
 * @class YHFileManager
 *
 * @abstract 文件组件
 *
 */
@interface YHFileManager : NSObject

/**
 *  判断指定路径下文件或文件夹是否存在，若存在则返回YES，若不存在则创建，返回创建成功失败信息
 *
 *  @param filepath 路径
 *  @param type     类型，文件or文件夹
 *
 *  @return BOOL
 */
- (BOOL)isExistAtPath:(NSString *)filepath type:(FileType)type;
/**
 *  计算文件大小
 *
 *  @param path 要计算大小的文件路径
 *
 *  @return 大小单位 KB
 */
- (double)fileSizeAtPath:(NSString *)path;

/**
 *  计算目录大小
 *
 *  @param path 要计算大小的目录路径
 *
 *  @return 大小单位 KB
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

#pragma mark - 压缩相关
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
#pragma mark - 路径获取
//Documents路径
+ (NSString *)documentsPath;
//Library路径
+ (NSString *)libraryPath;
//tmp路径
+ (NSString *)tmpPath;
//Caches路径
+ (NSString *)cachesPath;
//Preferences路径
+ (NSString *)preferencesPath;
@end
