//
//  FileDownLoadModel.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHFileDownLoadModel.h"

#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

@implementation YHFileDownLoadModel

//创建一个新任务
+ (instancetype)modelWithUrl:(NSString *)url filePath:(NSString *)filePath {

    YHFileDownLoadModel *model = [[self alloc] init];
    model.url = url;
    model.filePath = filePath;
    model.name = url.lastPathComponent;
    model.sigleID = [url md5];
    model.status = YHFileDownloadWaiting;
    return model;
}

- (NSString *)absolutePath {

    return [[kDocumentPath stringByAppendingPathComponent:self.filePath] stringByAppendingPathComponent:self.name];
}

- (void)setStatus:(YHFileDownloadStatus)status {

    _status = status;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.statusBlock) {
            self.statusBlock(self);
        }
    });
}

- (void)setProgress:(double)progress {

    _progress = progress;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.progressBlock) {
            self.progressBlock(self);
        }
    });
}
// 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
+ (NSArray *)modelPropertyBlacklist {
    return @[@"operation",@"absolutePath"];
}

@end
