//
//  YHNetWork.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/5.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

//缓存对象
@interface CacheObj : NSObject

@property (nonatomic,copy) NSString *url;
@property (nonatomic,strong) NSDictionary *parameter;
@property (nonatomic,copy) NSString *requestTime;
@property (nonatomic,copy) NSString *responseTime;
@property (nonatomic,copy) NSString *responseJsonStr;

@end
#pragma mark - UploadObj

typedef NS_ENUM(NSInteger,UploadType) {

    UploadFile = 1,
    UploadData,
};
//上传文件配置对象
@interface UploadObj : NSObject

@property (nonatomic,copy) NSString *url;
@property (nonatomic,strong) NSDictionary *parameter;
@property (nonatomic,assign) UploadType type;

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *fileName;
@property (nonatomic,copy) NSString *mimeType;

@property (nonatomic,copy) NSString *fileUrl;
@property (nonatomic,strong) NSData *data;

@end

//成功回调
typedef void(^requestSuccessBlock)(id responseObj);
//失败回调
typedef void(^requestFailureBlock)(NSError *error);

/**
 * @class  YHNetWork
 *
 * @abstract 网络框架
 *
 */
@interface YHNetWork : NSObject

#pragma mark - 请求
/**
 *  Get请求
 *
 *  @param URLString  请求地址
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return NSURLSessionDataTask可以用来取消任务
 */
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(id)parameters
                               success:(requestSuccessBlock)success
                               failure:(requestFailureBlock)failure;

/**
 *  post请求
 *
 *  @param URLString  请求地址
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return NSURLSessionDataTask可以用来取消任务
 */

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(id)parameters
                                success:(requestSuccessBlock)success
                                failure:(requestFailureBlock)failure;

/**
 *  上传文件
 *
 *  @param obj                 上传文件配置对象
 *  @param uploadProgressBlock 上传进度，需要更新UI的可放在此处
 *  @param completionHandler   上传完成回调
 *
 *  @return NSURLSessionDataTask可以用来取消任务
 */
- (NSURLSessionUploadTask *)uploadTaskWithUploadObj:(UploadObj *)obj
                                           progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                                  completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;
/**
 *  下载文件
 *
 *  @param URLString           请求地址
 *  @param uploadProgressBlock 下载进度
 *  @param fileLocationURL     文件下载本地存放路径
 *  @param completionHandler   下载完成回调
 *
 *  @return NSURLSessionDataTask可以用来取消任务
 */
- (NSURLSessionDownloadTask *)downlaodTaskWithUrl:(NSString *)URLString
                                         progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                      destination:(NSString *)fileLocationURL
                                completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

#pragma mark - settings
//设置请求超时时间
+ (void)setRequestTimeOut:(NSTimeInterval)time;
//设置通用参数
+ (void)setCommonParam:(NSDictionary *)dic;
//获取通用参数
+ (NSDictionary *)getCommonParam;
//不使用通用参数,list为不使用通用参数的url
+ (void)blackListNotUseCommonParam:(NSArray *)list;
//设置请求头内容
- (void)setValue:(NSString *)value forHttpHeader:(NSString *)header;
//获取所有请求头内容
- (NSDictionary *)getAllHeader;
//设置返回内容接收类型
- (void)setResponseAcceptableContentType:(NSString *)type;
//获取所有可接受内容类型
- (NSSet *)getAllresponseAcceptableContentType;
//设置是否使用缓存
- (void)isUseCache:(BOOL)flag;
//清除缓存
- (void)clearCache;
//设置证书
- (void)setCerPath:(NSString *)cerPath;

@end
