//
//  YHFileManager.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/30.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHFileManager.h"
#import "YHFileAction.h"
#import "YHFileCompress.h"

@interface YHFileManager ()

@property (nonatomic,strong) YHFileAction *fileAction;

@end

@implementation YHFileManager

#pragma mark - define
- (BOOL)isExistAtPath:(NSString *)filepath type:(FileType)type {

    if (type == FileTypeFile) {
        
        return [self.fileAction fileIsExistAtPath:filepath];
    } else if (type == FileTypeDirectory) {
        return [self.fileAction directoryIsExistAtPath:filepath];
    }
    return NO;
}

- (double)fileSizeAtPath:(NSString *)path {

    return [self.fileAction fileSizeAtPath:path]/1024.0;
}

- (double)folderSizeAtPath:(NSString *)path {

    return [self.fileAction folderSizeAtPath:path]/1024.0;
}

- (void)clearDirectory:(NSString *)path {

    [self.fileAction clearDirectory:path];
}

- (void)clearFile:(NSString *)path {
    
    [self.fileAction clearFile:path];
}

- (NSArray *)fileNameWithPath:(NSString *)path {

    return [self.fileAction fileNameWithPath:path];
}

- (NSArray *)filePathWithPath:(NSString *)path {

    return [self.fileAction filePathWithPath:path];
}


#pragma mark - 压缩相关
/**
 *  压缩指定文件夹内的所有文件
 *
 *  @param path      需要压缩的文件夹路径
 *  @param toPath    输出目录
 *  @param fileName  输出文件名称（不需要带后缀，执行完成后会自动加上.zip后缀）
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)zipArchiveFolderWithPath:(NSString *)path toPath:(NSString *)toPath fileName:(NSString *)fileName pwd:(NSString *)pwdString {
    
    [YHFileCompress zipArchiveFolderWithPath:path toPath:toPath fileName:fileName pwd:pwdString];
}

/**
 *  压缩指定的多个文件
 *
 *  @param pathArr   文件路径数组
 *  @param toPath    输出目录
 *  @param fileName  输出文件名称（不需要带后缀，执行完成后会自动加上.zip后缀）
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)zipArchiveFilesWithPathArr:(NSArray *)pathArr toPath:(NSString *)toPath fileName:(NSString *)fileName pwd:(NSString *)pwdString {

    [YHFileCompress zipArchiveFilesWithPathArr:pathArr toPath:toPath fileName:fileName pwd:pwdString];
}

/**
 *  压缩指定的单个文件
 *
 *  @param path      文件路径
 *  @param toPath    输出目录
 *  @param fileName  输出文件名称（不需要带后缀，执行完成后会自动加上.zip后缀）
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)zipArchiveFileWithPath:(NSString *)path toPath:(NSString *)toPath fileName:(NSString *)fileName pwd:(NSString *)pwdString {

    [YHFileCompress zipArchiveFileWithPath:path toPath:toPath fileName:fileName pwd:pwdString];
}
/**
 *  解压缩zip文件
 *
 *  @param path      需要解压的zip文件路径
 *  @param toPath    输出目录
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)unzipOpenFileWithPath:(NSString *)path toPath:(NSString *)toPath pwd:(NSString *)pwdString {

    [YHFileCompress unzipOpenFileWithPath:path toPath:toPath pwd:pwdString];
}

#pragma mark - 路径获取
//Documents路径
+ (NSString *)documentsPath {

    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}
//Library路径
+ (NSString *)libraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}
//tmp路径
+ (NSString *)tmpPath {

    return NSTemporaryDirectory();
}
//Caches路径
+ (NSString *)cachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
};
//Preferences路径
+ (NSString *)preferencesPath {

    return [[self libraryPath] stringByAppendingPathComponent:@"Preferences"];
}
#pragma mark - getter/setter

- (YHFileAction *)fileAction {

    if (!_fileAction) {
        _fileAction = [YHFileAction defaultAction];
    }
    return _fileAction;
}

@end
