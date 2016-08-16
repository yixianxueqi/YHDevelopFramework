//
//  FileDownLoadManager.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHFileDownLoadModel.h"
#import "YHFileDownLoadOperation.h"
#import "YHFileHelper.h"
#import "YHFileDownloadStore.h"

typedef void(^TaskStatusObserveBlock)(YHFileDownLoadModel *model);

/**
 * @class FileDownLoadManager
 *
 * @abstract 多文件下载管理中心
 *
 */
@interface YHFileDownLoadManager : NSObject

+ (instancetype)sharedManager;
//返回所有任务sigleID(包含:未开始的，正在进行的，失败的)
- (NSArray *)showAllTask;
//根据唯一标识查询下载对象
- (YHFileDownLoadModel *)modelWithSigleID:(NSString *)sigleID;
//设置同时最多任务下载数,最多5（不符合的将会设置为默认:3）
- (void)setMaxDownloadCount:(NSInteger)count;
/**
 *  创建一个任务
 *
 *  @param URLString 下载地址
 *  @param filePath  文件存储目录
 *  @param name 文件名字
 *  @return 该任务唯一标识
 */
- (NSString *)addTaskWithURL:(NSString *)URLString filePath:(NSString *)filePath;
/**
 *  启动下载任务
 *
 *  @param sigleID 任务的唯一标识
 */
- (void)startTask:(NSString *)sigleID;
/**
 *  暂停下载任务
 *
 *  @param sigleID 任务的唯一标识
 */
- (void)suspendTask:(NSString *)sigleID;
/**
 *  继续下载任务
 *
 *  @param sigleID 任务的唯一标识
 */
- (void)continueTask:(NSString *)sigleID;
/**
 *  停止任务
 *
 *  @param sigleID 任务的唯一标识
 */
- (void)stopTask:(NSString *)sigleID;
/**
 *  删除任务
 *
 *  @param sigleID 任务的唯一标识
 */
- (void)deleteTask:(NSString *)sigleID;


@end
