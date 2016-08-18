//
//  FileDownLoadOperation.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHFileDownLoadOperation.h"


#define k_executing @"isExecuting"
#define k_cancelled @"isCancelled"
#define k_finished @"isFinished"
//#define k_ready @"ready"

@interface YHFileDownLoadOperation ()<NSURLSessionDataDelegate>
{
    BOOL _executing;
//    BOOL _cancelled;
    BOOL _finished;
    //    BOOL _ready;
}
@property (nonatomic,strong) YHFileDownLoadModel *model;
@property (nonatomic,strong) NSURLSession *session;
@property (nonatomic,strong) NSURLSessionDataTask *dataTask;
@property (nonatomic,strong) NSOutputStream *outputStream;

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
    [self.dataTask suspend];
    self.model.status = YHFileDownloadSuspend;
    [self didChangeValueForKey:k_executing];
    
}
//继续任务
- (void)resumeTask {
    
    [self willChangeValueForKey:k_executing];
    _executing = YES;
    [self.dataTask resume];
    self.model.status = YHFileDownloaddownload;
    [self didChangeValueForKey:k_executing];
}
#pragma mark - private
//创建下载任务
- (void)creatDownloadSessionTask {
    
    self.model.currentSize = [YHFileHelper fileSize:self.model.absolutePath];
    self.model.status = YHFileDownloadWaiting;
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.model.url]];
    //设置请求头
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-",self.model.currentSize];
    [request setValue:range forHTTPHeaderField:@"Range"];
    self.dataTask = [self.session dataTaskWithRequest:request];
    
}
#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {

    self.outputStream = [NSOutputStream outputStreamToFileAtPath:self.model.absolutePath append:YES];
    [self.outputStream open];
    self.model.totalSize = response.expectedContentLength;
    self.model.status = YHFileDownloaddownload;
    //允许收到响应
    completionHandler(NSURLSessionResponseAllow);
}
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    [self.outputStream write:data.bytes maxLength:data.length];
    self.model.currentSize += data.length;
    if (self.model.totalSize > 0) {
        double pg = (double)self.model.currentSize / self.model.totalSize;
        self.model.progress = pg;
    }
}
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    
    if (error) {
        NSLog(@"error: %@",error);
        self.model.status = YHFileDownloadFailure;
    } else {
        self.model.status = YHFileDownloadFinshed;
        [self completion];
    }
    [self.outputStream close];
    self.outputStream = nil;
    [self.session finishTasksAndInvalidate];
}
#pragma mark - override

- (void)start {

    self.model.status = YHFileDownloadBegin;
    if (self.isCancelled) {
        [self willChangeValueForKey:k_finished];
        _finished = YES;
        [self didChangeValueForKey:k_finished];
    } else {
        [self willChangeValueForKey:k_executing];
        _executing = YES;
        [self.dataTask resume];
        self.model.status = YHFileDownloadBegin;
        [self didChangeValueForKey:k_executing];
    }
}

- (void)cancel {
    
    [self willChangeValueForKey:k_cancelled];
    [super cancel];
    [self.dataTask cancel];
    self.dataTask = nil;
    [self didChangeValueForKey:k_cancelled];
    [self completion];
}

- (void)completion {

    [self willChangeValueForKey:k_executing];
    [self willChangeValueForKey:k_finished];
    _executing = NO;
    _finished = YES;
    [self didChangeValueForKey:k_executing];
    [self didChangeValueForKey:k_finished];
}
- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

@end
