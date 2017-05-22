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

//观察任务变化block
typedef void(^FileDownLoadObserveTaskBlock)(YHFileDownloadStatus status,double progress);
//当任务完成后，将会在此block抛出，并且从下载管理中心移除此项
typedef void(^FileDownLoadCompleteBlock)(YHFileDownLoadModel *model);
/**
 * @class FileDownLoadManager
 *
 * @abstract 多文件下载管理中心
 *
 */
@interface YHFileDownLoadManager : NSObject

+ (instancetype)sharedManager;
/**
 *  设置最大并发量
 *
 *  @notice 上限为5，默认3，不能为0
 *  @param count 个数
 */
- (void)setMaxSubThread:(NSInteger)count;
//获取下载对象
- (YHFileDownLoadModel *)getFileDownloadModelWithSigleID:(NSString *)sigleID;
//获取任务状态
- (YHFileDownloadStatus)getTaskStatusWithSigleID:(NSString *)sigleID;
//观察任务执行情况
- (void)observeTaskWithSigleID:(NSString *)sigleID block:(FileDownLoadObserveTaskBlock)block;
//当下载任务项完成时会在此抛出
- (void)completeBlock:(FileDownLoadCompleteBlock)block;
/**
 *  添加一个新任务
 *
 *  @param url 下载链接地址
 *  @param dir 存储目录，Document目录下+自定义目录
 *
 *  @return 该任务的唯一标示
 */
- (NSString *)addTaskWithUrl:(NSString *)url saveDirectory:(NSString *)dir;
/**
 *  开始任务
 *
 *  @param sigleID 任务sigleID
 */
- (void)startTaskWithSigleID:(NSString *)sigleID;
/**
 *  暂停任务
 *
 *  @param sigleID 任务sigleID
 */
- (void)suspendTaskWithSigleID:(NSString *)sigleID;
/**
 *  继续任务
 *
 *  @param sigleID 任务sigleID
 */
- (void)resumeTaskWithSigleID:(NSString *)sigleID;
/**
 *  撤销任务
 *
 *  @param sigleID 任务sigleID
 */
- (void)cancelTaskWithSigleID:(NSString *)sigleID;

@end
