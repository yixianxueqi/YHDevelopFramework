//
//  NewsTableViewDelegate.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/24.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataSource;

@end
