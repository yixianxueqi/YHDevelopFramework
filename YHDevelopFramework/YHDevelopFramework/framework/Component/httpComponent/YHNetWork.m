//
//  YHNetWork.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/5.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHNetWork.h"
#import "YHTools.h"
#import "NSString+Secret.h"
#import "YHNetCache.h"
#import "NSObject+JsonAndDic.h"

#define kCommonParamKey @"networkCommonParam"
//error domain
#define kYHNetworkConnection @"YHNetwork.Connection"
//网络连接错误
#define kNetworkConnectionError [NSError errorWithDomain:kYHNetworkConnection code:NSURLErrorNotConnectedToInternet userInfo:@{NSLocalizedDescriptionKey:@"网络连接已断开，请检查网络"}]

#pragma mark - CacheObj
@implementation CacheObj

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
    return [self.sessionManager GET:URLString parameters:realDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //缓存请求成功的内容
        [weakSelf cacheHttpRequestBeginTime:beginTime responseObj:responseObject requestEndTime:[self getCurrentTimeStamp] sigleID:sigleID];
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
    return [self.sessionManager POST:URLString parameters:realDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //缓存请求成功的内容
        [weakSelf cacheHttpRequestBeginTime:beginTime responseObj:responseObject requestEndTime:[self getCurrentTimeStamp] sigleID:sigleID];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self networkFailureHandle:error];
    }];
}

#pragma mark - settings
//设置请求超时时间
+ (void)setRequestTimeOut:(NSTimeInterval)time {

    networkTimeout = time;
}
//设置通用参数
+ (void)setCommonParam:(NSDictionary *)dic {
    
    sanBoxStore(kCommonParamKey, dic);
}
//获取通用参数
+ (NSDictionary *)getCommonParam {
    
    return sanBoxTake(kCommonParamKey);
}
//不使用通用参数的url
+ (void)blackListNotUseCommonParam:(NSArray *)list {

    NSMutableArray *listM = [NSMutableArray array];
    //将url转化为MD5字符串，便于比较使用
    for (NSString *str in list) {
        [listM addObject:[str md5]];
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
#pragma mark - define
//设置请求的超时时间
- (void)setRequestTimeoutSeconds:(NSTimeInterval)seconds {

    self.sessionManager.requestSerializer.timeoutInterval = seconds;
}
//校验请求参数,若有公共参数且不再黑名单，则补充
- (NSDictionary *)validateParameter {

    NSDictionary *commonDic = [self.class getCommonParam];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:self.dic];
    if (![blackList containsObject:[self.url md5]]) {
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
        NSString *jsonStr = [[obj toDic] toJsonString];
        [[YHNetCache sharedCache] setObject:jsonStr forKey:sigleID];
    });
}
//校验是否使用缓存
- (CacheObj *)validateCacheForsigleID:(NSString *)sigleID {

    YHNetCache *cache = [YHNetCache sharedCache];
    if ([cache containsObjectForKey:sigleID]) {
        NSString *json = [cache objectForKey:sigleID];
        NSDictionary *dic = [self jsonToDic:json];
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

    NSString *parameterJsonStr = [self.dic toJsonString];
    NSString *str = [NSString stringWithFormat:@"%@%@",self.url,parameterJsonStr];
    return [str md5];
}

#pragma mark - getter/setter

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}

@end
