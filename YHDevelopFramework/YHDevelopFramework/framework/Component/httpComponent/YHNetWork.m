//
//  YHNetWork.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/5.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHNetWork.h"
#import "YHNetCache.h"
#import <YYKit/YYKit.h>

#define kCommonParamKey @"networkCommonParam"
//error domain
#define kYHNetworkConnection @"YHNetwork.Connection"
//网络连接错误
#define kNetworkConnectionError [NSError errorWithDomain:kYHNetworkConnection code:NSURLErrorNotConnectedToInternet userInfo:@{NSLocalizedDescriptionKey:@"网络连接已断开，请检查网络"}]

#pragma mark - CacheObj
@implementation CacheObj

@end

#pragma mark - UploadObj
@implementation UploadObj

@end

#pragma mark - YHNetwork

@interface YHNetWork ()

@property (nonatomic,assign) AFHTTPSessionManager *sessionManager;
@property (nonatomic,assign) BOOL useCache;

@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSDictionary *dic;
@property (nonatomic,copy) requestSuccessBlock success;
@property (nonatomic,copy) requestFailureBlock failure;

@end

//超时时间
static NSTimeInterval networkTimeout = 30.f;
//不使用通用参数的黑名单
static NSArray *blackList;

@implementation YHNetWork

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self setValue:@"application/json" forHttpHeader:@"Content-Type"];
        [self setResponseAcceptableContentType:@"text/html"];
    }
    return self;
}

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
                      failure:(requestFailureBlock)failure {

    self.url = URLString;
    self.success = success;
    self.failure = failure;
    self.dic = parameters;
    //请求超时时间
    [self setRequestTimeoutSeconds:networkTimeout];
    //公用参数
    NSDictionary *realDic = [self validateParameter];
    self.dic = realDic;
    //生成该请求的唯一标示，由url和参数经md5加密后生成
    NSString *sigleID = [self sigleID];
    //缓存
    if (self.useCache) {
        //若使用缓存
        CacheObj *obj = [self validateCacheForsigleID:sigleID];
        if (obj && success) {
            //缓存存在
            success(obj.responseJsonStr);
            return nil;
        }
    }
    //发送请求
    NSString *beginTime = [self getCurrentTimeStamp];
    __weak typeof(self) weakSelf = self;
    NSLog(@"http -> url:%@ \nparameters:\n%@ \n",URLString,realDic);
    return [self.sessionManager GET:URLString parameters:realDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //缓存请求成功的内容
        [weakSelf cacheHttpRequestBeginTime:beginTime responseObj:responseObject requestEndTime:[self getCurrentTimeStamp] sigleID:sigleID];
        NSLog(@"responseObject: %@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self networkFailureHandle:error];
    }];
}

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
                       failure:(requestFailureBlock)failure {

    self.url = URLString;
    self.success = success;
    self.failure = failure;
    self.dic = parameters;
    //请求超时时间
    [self setRequestTimeoutSeconds:networkTimeout];
    //公用参数
    NSDictionary *realDic = [self validateParameter];
    self.dic = realDic;
    //生成该请求的唯一标示，由url和参数经md5加密后生成
    NSString *sigleID = [self sigleID];
    //缓存
    if (self.useCache) {
        //若使用缓存
        CacheObj *obj = [self validateCacheForsigleID:sigleID];
        if (obj && success) {
            //缓存存在
            success(obj.responseJsonStr);
            return nil;
        }
    }
    //发送请求
    NSString *beginTime = [self getCurrentTimeStamp];
    __weak typeof(self) weakSelf = self;
    NSLog(@"http -> url:%@ \nparameters:\n%@ \n",URLString,realDic);
    return [self.sessionManager POST:URLString parameters:realDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //缓存请求成功的内容
        [weakSelf cacheHttpRequestBeginTime:beginTime responseObj:responseObject requestEndTime:[self getCurrentTimeStamp] sigleID:sigleID];
        NSLog(@"responseObject: %@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self networkFailureHandle:error];
    }];
}
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
                                  completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler {
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:obj.url parameters:obj.parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (obj.type == UploadData) {
            //上传data
            [formData appendPartWithFileData:obj.data name:obj.name fileName:obj.fileName mimeType:obj.mimeType];
        } else {
            //上传文件
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:obj.fileUrl] name:obj.name fileName:obj.fileName mimeType:obj.mimeType error:nil];
        }
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    [serializer setAcceptableContentTypes:[NSSet setWithArray:@[@"application/json",@"text/json",@"text/html",@"text/javascript"]]];
    manager.responseSerializer = serializer;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (uploadProgressBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                uploadProgressBlock(uploadProgress);
            });
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completionHandler) {
            completionHandler(response,responseObject,error);
        }
    }];
    [uploadTask resume];
    return uploadTask;
}
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
                                completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [manager setDownloadTaskDidFinishDownloadingBlock:^NSURL * _Nullable(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, NSURL * _Nonnull location) {
        
        return [NSURL fileURLWithPath:[fileLocationURL stringByAppendingPathComponent:downloadTask.response.suggestedFilename]];
    }];
    NSURLSessionDownloadTask *dowloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadProgressBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                downloadProgressBlock(downloadProgress);
            });
        }
    } destination:nil completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (completionHandler) {
            completionHandler(response,filePath,error);
        }
    }];
    [dowloadTask resume];
    return dowloadTask;
}

#pragma mark - settings
//设置请求超时时间
+ (void)setRequestTimeOut:(NSTimeInterval)time {

    networkTimeout = time;
}
//设置通用参数
+ (void)setCommonParam:(NSDictionary *)dic {
    
    [self sandBoxStoreValue:dic key:kCommonParamKey];
}
//获取通用参数
+ (NSDictionary *)getCommonParam {
    
    return [self sandBoxTakeValueForkey:kCommonParamKey];
}
//不使用通用参数的url
+ (void)blackListNotUseCommonParam:(NSArray *)list {

    NSMutableArray *listM = [NSMutableArray array];
    //将url转化为MD5字符串，便于比较使用
    for (NSString *str in list) {
        [listM addObject:[self stringMD5:str]];
    }
    blackList = listM;
}
//设置请求头内容
- (void)setValue:(NSString *)value forHttpHeader:(NSString *)header {

    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:header];
}
//获取所有请求头内容
- (NSDictionary *)getAllHeader {
    
    return [self.sessionManager.requestSerializer HTTPRequestHeaders];
}
//设置返回内容接收类型
- (void)setResponseAcceptableContentType:(NSString *)type {

    [self.sessionManager.responseSerializer setAcceptableContentTypes:[[self.sessionManager.responseSerializer acceptableContentTypes] setByAddingObject:type]];
}
//获取所有可接受内容类型
- (NSSet *)getAllresponseAcceptableContentType {

    return [self.sessionManager.responseSerializer acceptableContentTypes];
}
//设置是否使用缓存
- (void)isUseCache:(BOOL)flag {

    self.useCache = flag;
}
//清除缓存
- (void)clearCache {
    [[YHNetCache sharedCache] removeObjectforKey:[self sigleID]];
}
//设置证书
- (void)setCerPath:(NSString *)cerPath {
    
    if (cerPath && cerPath.length > 0) {
        //路径存在
        NSData * certData =[NSData dataWithContentsOfFile:cerPath];
        NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        // 是否允许,NO-- 不允许无效的证书
        [securityPolicy setAllowInvalidCertificates:YES];
        //如置为NO，建议自己添加对应域名的校验逻辑。
        securityPolicy.validatesDomainName = NO;
        // 设置证书
        [securityPolicy setPinnedCertificates:certSet];
        self.sessionManager.securityPolicy = securityPolicy;
    }
}
#pragma mark - define
//设置请求的超时时间
- (void)setRequestTimeoutSeconds:(NSTimeInterval)seconds {

    self.sessionManager.requestSerializer.timeoutInterval = seconds;
}
//校验请求参数,若有公共参数且不再黑名单，则补充
- (NSDictionary *)validateParameter {

    NSDictionary *commonDic = [self.class getCommonParam];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:self.dic];
    if (![blackList containsObject:[[self class] stringMD5:self.url]]) {
        [dictM setDictionary:commonDic];
    }
    return dictM;
}
//缓存内容
- (void)cacheHttpRequestBeginTime:(NSString *)beginTime responseObj:(NSString *)responseObj requestEndTime:(NSString *)endTime sigleID:(NSString *)sigleID {
    
    //异步子线程缓存
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CacheObj *obj = [[CacheObj alloc] init];
        obj.url = self.url;
        obj.requestTime = beginTime;
        obj.parameter = self.dic;
        obj.responseTime = endTime;
        obj.responseJsonStr = responseObj;
        NSString *jsonStr = [obj modelToJSONString];
        [[YHNetCache sharedCache] setObject:jsonStr forKey:sigleID];
    });
}
//校验是否使用缓存
- (CacheObj *)validateCacheForsigleID:(NSString *)sigleID {

    YHNetCache *cache = [YHNetCache sharedCache];
    if ([cache containsObjectForKey:sigleID]) {
        NSString *json = [cache objectForKey:sigleID];
        NSDictionary *dic = [[self class] jsonToDic:json];
        CacheObj *obj = [[CacheObj alloc] init];
        obj.url = dic[@"url"];
        obj.requestTime = dic[@"requestTime"];
        obj.parameter = dic[@"parameter"];
        obj.responseJsonStr = dic[@"responseJsonStr"];
        obj.responseTime = dic[@"responseTime"];
        NSLog(@"network Cache -> url:%@ \n parameter:%@ \n response: %@\n",obj.url,obj.parameter,obj.responseJsonStr);
        return obj;
    }
    return nil;
}
//网络请求失败处理
- (void)networkFailureHandle:(NSError *)error {

    if (self.failure) {
        //错误回调存在
        if (error.code == NSURLErrorNotConnectedToInternet) {
            self.failure(kNetworkConnectionError);
        } else {
            self.failure(error);
        }
    }
}
//获取当前时间时间戳
- (NSString *)getCurrentTimeStamp {

    return [NSString stringWithFormat:@"%ld",(long)([[NSDate date] timeIntervalSince1970] * 1000)];
}
//根据url和参数生成唯一标示，作为缓存的唯一标示
- (NSString *)sigleID {

    NSString *parameterJsonStr = [self.dic modelToJSONString];
    NSString *str = [NSString stringWithFormat:@"%@%@",self.url,parameterJsonStr];
    return [[self class] stringMD5:str];
}

#pragma mark - tool
+ (NSString *)stringMD5:(NSString *)targetStr {

    return [targetStr md5String];;
}
//沙盒存
+ (void)sandBoxStoreValue:(id)value key:(NSString *)key {

    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
}
//沙盒取
+ (id)sandBoxTakeValueForkey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
//json转字典
+ (NSDictionary *)jsonToDic:(NSString *)jsonStr {
    
    if (!jsonStr || jsonStr.length == 0) {
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark - getter/setter

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}

@end
