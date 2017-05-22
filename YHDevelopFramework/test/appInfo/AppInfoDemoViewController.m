//
//  AppInfoDemoViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/30.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "AppInfoDemoViewController.h"
#import "AppInfoManager.h"

@interface AppInfoDemoViewController ()

@property (nonatomic, strong) AppInfoManager *manager;

@end

@implementation AppInfoDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.manager getAppInfoFromAppStore:^(NSDictionary *dic) {
        DDLogVerbose(@"%@",dic);
        DDLogVerbose(@"%@",dic[@"version"]);
    }];
}

- (IBAction)clickBtn:(UIButton *)sender {
    
    [self.manager entryAppStore];
}

- (AppInfoManager *)manager {
    
    if (!_manager) {
        _manager = [AppInfoManager sharedManagerWithAppID:@"414478124"];
    }
    return _manager;
}

@end
