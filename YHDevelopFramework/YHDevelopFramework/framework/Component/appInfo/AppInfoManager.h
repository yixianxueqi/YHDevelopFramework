//
//  AppInfoManager.h
//  testAppInfoFromeAPPStore
//
//  Created by 君若见故 on 16/12/30.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^appInfoBlock)(NSDictionary *);

@interface AppInfoManager : NSObject

+ (instancetype)sharedManagerWithAppID:(NSString *)appID;

- (void)getAppInfoFromAppStore:(appInfoBlock)infoBlock;
- (void)entryAppStore;

@end
