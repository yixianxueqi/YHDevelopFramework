//
//  NewsTableViewDelegate.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/24.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NewsTableViewDelegate.h"

@implementation NewsTableViewDelegate

- (void)setDataSource:(NSArray *)dataSource {

    _dataSource = dataSource;
}

#pragma mark - tableView delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];//self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"click At Index: %ld,%ld",indexPath.section,indexPath.row);
}

@end
