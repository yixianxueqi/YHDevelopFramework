//
//  ViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "ViewController.h"
#import "Entity.h"

@interface VCModel : Entity

@property (nonatomic,copy) NSString *vcName;
@property (nonatomic,copy) NSString *vcTitle;

@end

@implementation VCModel

@end


@interface ViewController ()<YHCrashHandle,YHLoggerHandle,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *list;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLogger];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    regClsCellT(self.tableView, [UITableViewCell class], @"cell");
    
}
#pragma mark - define

- (void)addLogger {

    [YHLogger defaultLog];
    [YHLogger setLogFormat:[[YHLogFormat alloc] init]];
    [YHLogger setFileLogLevel:DDLogLevelInfo];
    [YHLogger startCatchCrashInfo];
    [YHLogger getLogger].delegate = self;
}

- (UIViewController *)viewControllerWithModel:(VCModel *)model {

    UIViewController *viewController = [[NSClassFromString(model.vcName) alloc] init];
    viewController.navigationItem.title = model.vcTitle;
    return viewController;
}

#pragma mark - YHLoggerHandle

- (void)showAllNormalLogFilePath:(NSArray *)filePathList {

    DDLogVerbose(@"Alllog:%@",filePathList);
}

- (void)showALLCrashLogFilePath:(NSArray *)filePathList {

    DDLogVerbose(@"AllCrashLog: %@",filePathList);
}

- (void)oneNewCrashLogFileAvaliable:(NSString *)filePath {

    DDLogVerbose(@"NewCrashLog: %@",filePath);
}

#pragma mark - tableView delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    VCModel *model = self.list[indexPath.row];
    cell.textLabel.text = model.vcName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    VCModel *model = self.list[indexPath.row];
    [self.navigationController pushViewController:[self viewControllerWithModel:model] animated:YES];
}

#pragma mark - getter/setter

- (NSMutableArray *)list {

    if (!_list) {
        _list = [NSMutableArray array];
        NSArray *tempList = listFromPlist(@"VCList");
        for (NSDictionary *dic in tempList) {
            VCModel *model = [VCModel modelWithDictionary:dic];
            [_list addObject:model];
        }
    }
    return _list;
}

@end
