//
//  FileDownLoadModel.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Secret.h"
#import <NSObject+YYModel.h>

@class YHFileDownLoadOperation;
@class YHFileDownLoadModel;
//文件状态
typedef NS_ENUM(NSInteger,YHFileDownloadStatus) {
    //开始
    YHFileDownloadBegin = 1,
    //下载中
    YHFileDownloaddownload,
    //暂停
    YHFileDownloadSuspend,
    //完成
    YHFileDownloadFinshed,
    //等待
    YHFileDownloadWaiting,
    //失败
    YHFileDownloadFailure,
};
//状态变化回调
typedef void(^ObserveStatusBlock)(YHFileDownLoadModel *model);
//进度变化回调
typedef void(^ObserveProgressBlock)(YHFileDownLoadModel *model);
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
@property (nonatomic,assign) NSInteger totalSize;
//当前下载大小
@property (nonatomic,assign) NSInteger currentSize;
//进度状况
@property (nonatomic,assign) double progress;
//当前状态
@property (nonatomic,assign) YHFileDownloadStatus status;
//下载具体执行对象
@property (nonatomic,strong) YHFileDownLoadOperation *operation;
//状态回调block
@property (nonatomic,copy) ObserveStatusBlock statusBlock;
//进度回调
@property (nonatomic,copy) ObserveProgressBlock progressBlock;

//创建一个新任务
+ (instancetype)modelWithUrl:(NSString *)url filePath:(NSString *)filePath;

@end






















