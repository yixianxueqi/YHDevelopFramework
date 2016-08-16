//
//  FileDownLoadModel.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHFileDownLoadOperation;
//文件状态
typedef NS_ENUM(NSInteger,YHFileDownloadStatus) {
    //开始
    YHFileDownloadBegin = 1,
    //下载中
    YHFileDownloaddownload = 1 << 1,
    //暂停
    YHFileDownloadSuspend = 1 << 2,
    //完成
    YHFileDownloadFinshed = 1 << 3,
    //等待
    YHFileDownloadWaiting = 1 << 4,
    //失败
    YHFileDownloadFailure = 1 << 5,
};

/**
 * @class  FileDownLoadModel
 *
 * @abstract 文件下载对象
 *
 */
@interface YHFileDownLoadModel : NSObject

//唯一标识
@property (nonatomic,copy) NSString *sigleID;
//文件名字 xxx.xx
@property (nonatomic,copy) NSString *name;
//下载url
@property (nonatomic,copy) NSString *url;
//存储目录
@property (nonatomic,copy) NSString *filePath;
//下载文件的绝对路径
@property (nonatomic,copy) NSString *absolutePath;
//总大小
@property (nonatomic,assign) double totalSize;
//当前下载大小
@property (nonatomic,assign) double currentSize;
//进度状况
@property (nonatomic,assign) double progress;
//当前状态
@property (nonatomic,assign) YHFileDownloadStatus status;
//下载具体对象
@property (nonatomic,strong) YHFileDownLoadOperation *operation;

//创建一个新任务
+ (instancetype)modelWithUrl:(NSString *)url filePath:(NSString *)filePath;

@end






















