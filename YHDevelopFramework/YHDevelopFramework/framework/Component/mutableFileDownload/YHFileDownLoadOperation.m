//
//  FileDownLoadOperation.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHFileDownLoadOperation.h"


#define k_executing @"executing"
#define k_cancelled @"cancelled"
#define k_finished @"finished"
#define k_ready @"ready"

@interface YHFileDownLoadOperation ()<NSURLSessionDownloadDelegate>
{
    BOOL _executing;
    BOOL _cancelled;
    BOOL _finished;
    BOOL _ready;
}
@property (nonatomic,strong) YHFileDownLoadModel *model;
@property (nonatomic,strong) NSURLSession *session;
@property (nonatomic,strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic,strong) NSData *resumeData;

@end

@implementation YHFileDownLoadOperation

//创建任务
- (instancetype)initWithModel:(YHFileDownLoadModel *)model {

    self = [super init];
    if (self) {
        self.model = model;
        [self creatDownloadSessionTask];
    }
    return self;
}
//暂停任务
- (void)suspendTask {

    [self willChangeValueForKey:k_executing];
    _executing = NO;
    [self didChangeValueForKey:k_executing];
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        //暂停下载时获取已下载的数据
        self.resumeData = resumeData;
    }];
    
}
//继续任务
- (void)resumeTask {

    [self willChangeValueForKey:k_executing];
    _executing = YES;
    [self didChangeValueForKey:k_executing];
}
#pragma mark - private
//创建下载任务
- (void)creatDownloadSessionTask {

    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    self.downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:self.model.url]];
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {

    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {

    self.model.currentSize = totalBytesWritten;
    self.model.totalSize = totalBytesExpectedToWrite;
    self.model.progress = (double)totalBytesWritten/totalBytesExpectedToWrite;
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

#pragma mark - override

- (void)main {

}

- (void)start {

}

- (void)cancel {

}




@end
