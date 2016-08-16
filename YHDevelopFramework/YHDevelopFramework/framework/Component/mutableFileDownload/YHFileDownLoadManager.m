//
//  FileDownLoadManager.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHFileDownLoadManager.h"

#define kArrayName @"taskLists"

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
        manager.taskQueue.maxConcurrentOperationCount = 3;
        //从数据库加载数据
        [manager.taskLists addObjectsFromArray:[[YHFileDownloadStore sharedStore] showAllObject]];
        //添加对容器的观察，当容器元素个数发生变化，但不包含元素本身的变化
        [manager addObserver:manager forKeyPath:kArrayName options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        //注册通知，以便app退出时退出任务并保存当前状态
        [manager careAppLeave];
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

    [self removeObserver:self forKeyPath:kArrayName];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:kArrayName]) {
        YHFileDownLoadModel *model = [change valueForKey:@"new"];
        //根据容器元素数量变化更新数据库
        if (model) {
            //增加新的
            [[YHFileDownloadStore sharedStore] putObjct:model];
        } else {
            //删除旧的
            model = [change valueForKey:@"old"];
            [[YHFileDownloadStore sharedStore] deleteObjctForKey:model.sigleID];
        }
    }
}

#pragma mark - 观察数组容器变化，必须重写的两个方法
- (void)insertObject:(YHFileDownLoadModel *)object inTaskListsAtIndex:(NSUInteger)index {
    
    [self.taskLists insertObject:object atIndex:index];
}

- (void)removeObjectFromTaskListsAtIndex:(NSUInteger)index {
    
    [self.taskLists removeObjectAtIndex:index];
}

#pragma mark - define
//返回所有任务sigleID(包含:未开始的，正在进行的，失败的)
- (NSArray *)showAllTask {
    
    return self.taskLists;
}
//根据唯一标识查询下载对象
- (YHFileDownLoadModel *)modelWithSigleID:(NSString *)sigleID {
    
    return [self getModelWithSigleID:sigleID];
}
//设置同时最多任务下载数
- (void)setMaxDownloadCount:(NSInteger)count {

    if (count <= 0 || count > 5) {
        count = 3;
    }
    self.taskQueue.maxConcurrentOperationCount = count;
}
/**
 *  创建一个任务
 *
 *  @param URLString 下载地址
 *  @param filePath  文件存储目录
 *  @param name 文件名字
 *  @return 该任务唯一标识
 */
- (NSString *)addTaskWithURL:(NSString *)URLString filePath:(NSString *)filePath {

    YHFileDownLoadModel *model;
    if ([YHFileHelper directoryIsExistAtPath:filePath]) {
        model = [YHFileDownLoadModel modelWithUrl:URLString filePath:filePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:model.absolutePath]) {
            //此文件已经存在
            NSLog(@"文件名不能重复!");
            return nil;
        }
        [[self getValueArray] addObject:model];
    }
    return model.sigleID;
}
/**
 *  启动下载任务
 *
 *  @param sigleID 任务的唯一标识
 */
- (void)startTask:(NSString *)sigleID {
    
    YHFileDownLoadModel *model = [self getModelWithSigleID:sigleID];
    if (model.status != YHFileDownloadFinshed) {
        if (model.operation) {
            [model.operation resumeTask];
        } else {
            model.operation = [[YHFileDownLoadOperation alloc] initWithModel:model];
            [self.taskQueue addOperation:model.operation];
        }
    }
}
/**
 *  暂停下载任务
 *
 *  @param sigleID 任务的唯一标识
 */
- (void)suspendTask:(NSString *)sigleID {
 
    YHFileDownLoadModel *model = [self getModelWithSigleID:sigleID];
    if (model.status != YHFileDownloadSuspend) {
        [model.operation suspendTask];
        [[YHFileDownloadStore sharedStore] putObjct:model];
    }
}
/**
 *  继续下载任务
 *
 *  @param sigleID 任务的唯一标识
 */
- (void)continueTask:(NSString *)sigleID {

    YHFileDownLoadModel *model = [self getModelWithSigleID:sigleID];
    if (model.operation) {
        [model.operation resumeTask];
    } else {
        model.operation = [[YHFileDownLoadOperation alloc] initWithModel:model];
        [self.taskQueue addOperation:model.operation];
    }
}
/**
 *  停止任务
 *
 *  @param sigleID 任务的唯一标识
 */
- (void)stopTask:(NSString *)sigleID {

    YHFileDownLoadModel *model = [self getModelWithSigleID:sigleID];
    if (model.operation) {
        [model.operation cancel];
    }
}
/**
 *  删除任务
 *
 *  @param sigleID 任务的唯一标识
 */
- (void)deleteTask:(NSString *)sigleID {

    YHFileDownLoadModel *model = [self getModelWithSigleID:sigleID];
    if (model.operation) {
        [model.operation cancel];
    }
    [[self getValueArray] removeObject:model];
}

#pragma mark - private
//注册app退出时的通知
- (void)careAppLeave {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopDownloadAndStore) name:UIApplicationWillTerminateNotification object:nil];
}
//当app即将退出时所作
- (void)stopDownloadAndStore {

    //所有等待的任务取消任务
    for (YHFileDownLoadModel *model in self.taskLists) {
        if (model.status == YHFileDownloadWaiting) {
            [model.operation cancel];
        }
    }
    //所有正在进行的任务挂起
    for (YHFileDownLoadModel *model in self.taskLists) {
        if (model.status == YHFileDownloaddownload) {
            [model.operation suspendTask];
        }
    }
    
}
//根据sigleID获取model
- (YHFileDownLoadModel *)getModelWithSigleID:(NSString *)sigleID {

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sigleID = %@",sigleID];
    NSArray *list = [self.taskLists filteredArrayUsingPredicate:predicate];
    return [list firstObject];
}
//特殊方法获取数组，观察者模式
- (NSMutableArray *)getValueArray {
    
    return [self mutableArrayValueForKey:kArrayName];
}
#pragma mark - getter/setter 
- (NSOperationQueue *)taskQueue {

    if (!_taskQueue) {
        _taskQueue = [[NSOperationQueue alloc] init];
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
