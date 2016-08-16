//
//  FileDownLoadOperation.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/10.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHFileHelper.h"
#import "YHFileDownLoadModel.h"
/**
 * @class  FileDownLoadOperation
 *
 * @abstract 文件下载的实际执行者
 *
 */
@interface YHFileDownLoadOperation : NSOperation

//创建任务
- (instancetype)initWithModel:(YHFileDownLoadModel *)model;
//暂停任务
- (void)suspendTask;
//继续任务
- (void)resumeTask;

@end
