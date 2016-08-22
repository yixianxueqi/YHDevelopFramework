//
//  DeviceInfoViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "DeviceInfoViewController.h"
#import "YHDeviceTools.h"

@interface DeviceModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *value;

+ (instancetype)modelWithName:(NSString *)name value:(NSString *)value;

@end

@implementation DeviceModel

+ (instancetype)modelWithName:(NSString *)name value:(NSString *)value {

    DeviceModel *model = [[self alloc] init];
    model.name = name;
    model.value = value;
    return model;
}

@end

#pragma mark - DeviceInfoViewController

@interface DeviceInfoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *list;

@end

@implementation DeviceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - tableView delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    DeviceModel *model = self.list[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.value;
    return cell;
}
#pragma mark - getter/setter
- (NSMutableArray *)list {

    if (!_list) {
        _list = [NSMutableArray array];
        [_list addObject:[DeviceModel modelWithName:@"appName" value:[YHDeviceTools appName]]];
        [_list addObject:[DeviceModel modelWithName:@"appVersion" value:[YHDeviceTools appVersion]]];
        [_list addObject:[DeviceModel modelWithName:@"bundleIdentifier" value:[YHDeviceTools bundleIdentifier]]];
        [_list addObject:[DeviceModel modelWithName:@"buildVersion" value:[YHDeviceTools appBuildVersion]]];
        [_list addObject:[DeviceModel modelWithName:@"deviceSerialNum" value:[YHDeviceTools deviceSerialNum]]];
        [_list addObject:[DeviceModel modelWithName:@"uuid" value:[YHDeviceTools uuid]]];
        [_list addObject:[DeviceModel modelWithName:@"deviveNameDefineByUser" value:[YHDeviceTools deviceNameDefineByUser]]];
        [_list addObject:[DeviceModel modelWithName:@"deviceName" value:[YHDeviceTools deviceName]]];
        [_list addObject:[DeviceModel modelWithName:@"systemVersion" value:[YHDeviceTools deviceSystemVersion]]];
        [_list addObject:[DeviceModel modelWithName:@"deviceModel" value:[YHDeviceTools deviceModel]]];
        [_list addObject:[DeviceModel modelWithName:@"deviceLoacalModel" value:[YHDeviceTools deviceLocalModel]]];
        [_list addObject:[DeviceModel modelWithName:@"operatorInfo" value:[YHDeviceTools operatorInfo]]];
        [_list addObject:[DeviceModel modelWithName:@"batteryState" value:[NSString stringWithFormat:@"%ld",[YHDeviceTools batteryState]]]];
        [_list addObject:[DeviceModel modelWithName:@"batteryLevel" value:[NSString stringWithFormat:@"%lf",[YHDeviceTools batteryLevel]]]];
    }
    return _list;
}
@end
