//
//  AppInfoManager.m
//  testAppInfoFromeAPPStore
//
//  Created by 君若见故 on 16/12/30.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "AppInfoManager.h"

static NSString *const queryUrl = @"http://itunes.apple.com/lookup?id=%@";
static NSString *const entryApp = @"itms-apps://itunes.apple.com/app/id%@";
static NSString *const entryApp2 = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@";

@interface AppInfoManager ()

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) appInfoBlock resultBlock;

@end

@implementation AppInfoManager

static AppInfoManager *manager = nil;
+ (instancetype)sharedManagerWithAppID:(NSString *)appID {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.appId = appID;
    });
    return manager;
}

- (void)getAppInfoFromAppStore:(appInfoBlock)infoBlock {
    
    self.resultBlock = infoBlock;
    [self getAppInfo];
}

- (void)getAppInfo {

    NSString *urlStr = [NSString stringWithFormat:queryUrl,self.appId];
    NSURL *url = [NSURL URLWithString:urlStr];
    __weak typeof(self) weakSelf = self;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 30.0;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Get appInfo frome AppStore error: %@",error.localizedDescription);
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *info;
            if ([dic[@"resultCount"] integerValue] > 0) {
                info = [dic[@"results"] firstObject];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.resultBlock(info);
            });
        }
    }];
    [dataTask resume];
}

- (void)entryAppStore {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        NSString *str = [NSString stringWithFormat:entryApp,self.appId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    } else {
        NSString *str = [NSString stringWithFormat:entryApp2,self.appId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    }
}

@end













