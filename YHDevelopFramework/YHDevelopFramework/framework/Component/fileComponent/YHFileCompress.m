//
//  YHFileCompress.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/30.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHFileCompress.h"
#import <ZipArchive/ZipArchive.h>

@interface YHFileCompress ()

@end

@implementation YHFileCompress

/**
 *  压缩指定文件夹内的所有文件
 *
 *  @param path      需要压缩的文件夹路径
 *  @param toPath    输出目录
 *  @param fileName  输出文件名称（不需要带后缀，执行完成后会自动加上.zip后缀）
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)zipArchiveFolderWithPath:(NSString *)path toPath:(NSString *)toPath fileName:(NSString *)fileName pwd:(NSString *)pwdString{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        
        ZipArchive* zipFile = [[ZipArchive alloc] init];
        NSString *zipfilename = [NSString stringWithFormat:@"%@/%@.zip", toPath, fileName];
        //是否需要密码
        pwdString.length?[zipFile CreateZipFile2:zipfilename Password:pwdString]:[zipFile CreateZipFile2:zipfilename];
        
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [zipFile addFileToZip:absolutePath newname:fileName];
        }
        [zipFile CloseZipFile2];
    }
}

/**
 *  压缩指定的多个文件
 *
 *  @param pathArr   文件路径数组
 *  @param toPath    输出目录
 *  @param fileName  输出文件名称（不需要带后缀，执行完成后会自动加上.zip后缀）
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)zipArchiveFilesWithPathArr:(NSArray *)pathArr toPath:(NSString *)toPath fileName:(NSString *)fileName pwd:(NSString *)pwdString{
    ZipArchive* zipFile = [[ZipArchive alloc] init];
    NSString *zipfilename = [NSString stringWithFormat:@"%@/%@.zip", toPath, fileName];
    //是否需要密码
    pwdString.length?[zipFile CreateZipFile2:zipfilename Password:pwdString]:[zipFile CreateZipFile2:zipfilename];
    for (NSString *path in pathArr) {
        NSString *subFileName = [[NSFileManager defaultManager] displayNameAtPath:path];
        [zipFile addFileToZip:path newname:subFileName];
    }
    [zipFile CloseZipFile2];
}

/**
 *  压缩指定的单个文件
 *
 *  @param path      文件路径
 *  @param toPath    输出目录
 *  @param fileName  输出文件名称（不需要带后缀，执行完成后会自动加上.zip后缀）
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)zipArchiveFileWithPath:(NSString *)path toPath:(NSString *)toPath fileName:(NSString *)fileName pwd:(NSString *)pwdString{
    ZipArchive* zipFile = [[ZipArchive alloc] init];
    NSString *zipfilename = [NSString stringWithFormat:@"%@/%@.zip", toPath, fileName];
    //是否需要密码
    pwdString.length?[zipFile CreateZipFile2:zipfilename Password:pwdString]:[zipFile CreateZipFile2:zipfilename];
    NSString *subFileName = [[NSFileManager defaultManager] displayNameAtPath:path];
    [zipFile addFileToZip:path newname:subFileName];
    [zipFile CloseZipFile2];
}
/**
 *  解压缩zip文件
 *
 *  @param path      需要解压的zip文件路径
 *  @param toPath    输出目录
 *  @param pwdString 密码（不需要加密的话填nil）
 */
+ (void)unzipOpenFileWithPath:(NSString *)path toPath:(NSString *)toPath pwd:(NSString *)pwdString{
    ZipArchive* zipFile = [[ZipArchive alloc] init];
    //是否需要密码
    pwdString.length?[zipFile UnzipOpenFile:path Password:pwdString]:[zipFile UnzipOpenFile:path];
    if([zipFile UnzipOpenFile:path]){
        
        BOOL ret = [zipFile UnzipFileTo:toPath overWrite:YES];
        if(NO == ret){
            NSLog(@"unzip failed");
        }else{
            NSLog(@"unzip success");
        }
        [zipFile UnzipCloseFile];
    }
}

@end
