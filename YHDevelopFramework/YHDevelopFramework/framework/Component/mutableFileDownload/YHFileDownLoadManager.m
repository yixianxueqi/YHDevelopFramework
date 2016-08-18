//
//  FileDownLoadManager.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHFileDownLoadManager.h"

#define kArrayName @"taskLists"
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

@interface YHFileDownLoadManager ()

@property (nonatomic,strong) NSOperationQueue *taskQueue;
@property (nonatomic,strong) NSMutableArray *taskLists;

@end

@implementation YHFileDownLoadManager

static YHFileDownLoadManager *manager;
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        //注册通知，当应用将要退出时
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(storeDownloadList) name:UIApplicationWillTerminateNotification object:nil];
        //从数据库读取之前的下载列表
        [manager getDownloadListFromStore];
        //观察self.taskLists
        [manager addObserver:manager forKeyPath:@"taskLists" options:NSKeyValueObservingOptionNew context:nil];
    });
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    if (!manager) {
        manager = [super allocWithZone:zone];
    }
    return manager;
}

+ (id)copyWithZone:(struct _NSZone *)zone {
    return self;
}

- (void)dealloc {

    //销毁前，需要将当前下载列表对象进行存储
    [self storeDownloadList];
    //移除观察
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"taskLists"];
}

#pragma mark - define
/**
 *  设置最大并发量
 *
 *  @notice 上限为5，默认3，不能为0
 *  @param count 个数
 */
- (void)setMaxSubThread:(NSInteger)count {

    if (count >= 5) {
        self.taskQueue.maxConcurrentOperationCount = 5;
    } else if (count <= 0) {
        self.taskQueue.maxConcurrentOperationCount = 1;
    } else {
        self.taskQueue.maxConcurrentOperationCount = count;
    }
}
//获取下载对象
- (YHFileDownLoadModel *)getFileDownloadModelWithSigleID:(NSString *)sigleID {
    return [self modelWithSigleID:sigleID];
}
//获取任务状态
- (YHFileDownloadStatus)getTaskStatusWithSigleID:(NSString *)sigleID {

    return [[self modelWithSigleID:sigleID] status];
}
//观察任务执行情况
- (void)observeTaskWithSigleID:(NSString *)sigleID block:(FileDownLoadObserveTaskBlock)block {

    YHFileDownLoadModel *model = [self modelWithSigleID:sigleID];
    if (block) {
        model.statusBlock = ^(YHFileDownLoadModel *model){
            block(model.status,model.progress);
        };
        model.progressBlock = ^(YHFileDownLoadModel *model){
            block(model.status,model.progress);
        };
    }
}
/**
 *  添加一个新任务
 *
 *  @param url 下载链接地址
 *  @param dir 存储目录,Document目录下
 *
 *  @return 该任务的唯一标示
 */
- (NSString *)addTaskWithUrl:(NSString *)url saveDirectory:(NSString *)dir {

    YHFileDownLoadModel *model;
    NSString *path = [kDocumentPath stringByAppendingPathComponent:dir];
    if ([YHFileHelper directoryIsExistAtPath:path]) {
        model = [YHFileDownLoadModel modelWithUrl:url filePath:dir];
        YHFileDownLoadModel *temp = [self modelWithSigleID:model.sigleID];
        if (temp) {
            NSLog(@"Task is existed at download list");
        } else {
            [self.taskLists addObject:model];
        }
    }
    return model.sigleID;
}
/**
 *  开始任务
 *
 *  @param sigleID 任务sigleID
 */
- (void)startTaskWithSigleID:(NSString *)sigleID {

    YHFileDownLoadModel *model = [self modelWithSigleID:sigleID];
    if (model.operation) {
        [model.operation resumeTask];
    } else {
        model.operation = [[YHFileDownLoadOperation alloc] initWithModel:model];
        [self.taskQueue addOperation:model.operation];
    }
}
/**
 *  暂停任务
 *
 *  @param sigleID 任务sigleID
 */
- (void)suspendTaskWithSigleID:(NSString *)sigleID {

    YHFileDownLoadModel *model = [self modelWithSigleID:sigleID];
    if (model.status == YHFileDownloaddownload) {
        //只有下载中，才存在暂停操作
        [model.operation suspendTask];
    }
}
/**
 *  继续任务
 *
 *  @param sigleID 任务sigleID
 */
- (void)resumeTaskWithSigleID:(NSString *)sigleID {

    YHFileDownLoadModel *model = [self modelWithSigleID:sigleID];
    if (model.status == YHFileDownloadSuspend) {
        //只有暂停，才存在继续操作
        if (model.operation) {
            [model.operation resumeTask];
        } else {
            model.operation = [[YHFileDownLoadOperation alloc] initWithModel:model];
            [self.taskQueue addOperation:model.operation];
        }
    }
}
/**
 *  撤销任务
 *
 *  @param sigleID 任务sigleID
 */
- (void)cancelTaskWithSigleID:(NSString *)sigleID {
    
    YHFileDownLoadModel *model = [self modelWithSigleID:sigleID];
    //任何状态都存在撤销操作
    [model.operation cancel];
}
#pragma mark - private
//根据标识从列表获取下载对象
- (YHFileDownLoadModel *)modelWithSigleID:(NSString *)sigleID {

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sigleID = %@",sigleID];
    NSArray *list = [self.taskLists filteredArrayUsingPredicate:predicate];
    return [list firstObject];
}
//销毁前，处理状态，存储列表
- (void)storeDownloadList {

    for (YHFileDownLoadModel *model in self.taskLists) {
        if (model.status == YHFileDownloaddownload) {
            //下载中的暂停
            [self suspendTaskWithSigleID:model.sigleID];
        }
        //存储到数据库中
        [[YHFileDownloadStore sharedStore] putObjct:model];
    }
}
//从数据库读取之前的下载列表数据
- (void)getDownloadListFromStore {

    NSArray *list = [[YHFileDownloadStore sharedStore] showAllObject];
    [self.taskLists addObjectsFromArray:list];
}

#pragma mark - getter/setter 
- (NSOperationQueue *)taskQueue {

    if (!_taskQueue) {
        _taskQueue = [[NSOperationQueue alloc] init];
        _taskQueue.maxConcurrentOperationCount = 3;
    }
    return _taskQueue;
}
- (NSMutableArray *)taskLists {
    if (!_taskLists) {
        _taskLists = [NSMutableArray array];
    }
    return _taskLists;
}

@end
