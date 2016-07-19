//
//  ViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+YHDateFormat.h"
#import "YHDeviceTools.h"
#import "YHLogger.h"
#import "UIImageView+BorderChange.h"
#import "Entity.h"
#import "BaseView.h"

@interface ViewController ()<YHCrashHandle,YHLoggerHandle>

@property (weak, nonatomic) IBOutlet UIImageView *igv1;
@property (weak, nonatomic) IBOutlet UIImageView *igv2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%s",__func__);

//    [self testDate];
//    [self testDevice];
//    [self testLogger];
//    [self testYYModel];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self testHUD];
//    });
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.igv1 circleBorder];
    [self.igv2 cornerBorder:5];
//    [self testBGView];
}
#pragma mark - Test

- (void)testBGView {

    UIView *view = [[[BaseView alloc] init] getNoDataViewFrame:self.view.bounds];
    [self.view addSubview:view];
}

- (void)testHUD {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showLoading];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showMBProgressHUDWithText:@"我们是未来主义的接班人，好好学习，天天向上." duration:5.f];
    });
}

- (void)testYYModel {

    Entity *obj = [[Entity alloc] init];
    obj.ID = @"123";
    obj.describe = @"456";
    NSString *temp = [obj modelToJSONString];
    DDLogInfo(@"%@",temp);
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    Entity *obj2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    DDLogInfo(@"%p",obj);
    DDLogInfo(@"%p",obj2);
}

- (void)testLogger {
    
    [YHLogger defaultLog];
    [YHLogger setLogFormat:[[YHLogFormat alloc] init]];
    [YHLogger setFileLogLevel:DDLogLevelInfo];
    [YHLogger startCatchCrashInfo];
    [YHLogger getLogger].delegate = self;
     DDLogVerbose(@"Verbose");
     DDLogDebug(@"Debug");
     DDLogInfo(@"Info");
     DDLogWarn(@"Warn");
     DDLogError(@"Error");

    DDLogError(@"************");
    
    DDLogVerbose(@"Verbose");
    DDLogDebug(@"Debug");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"Error");
    
    NSArray *list = @[@"1",@"2",@"3",@"4"];
    for (int i = 0; i < 5; i++) {
        DDLogVerbose(@"%@",list[i]);
    }
}

#pragma mark - YHCrashHandle

- (void)crashHandleCatchOneNewCrash:(NSString *)crashDetailInfo {

    NSLog(@"%@",crashDetailInfo);
}

- (void)testDevice {

    NSLog(@"%@",[YHDeviceTools appName]);
    NSLog(@"%@",[YHDeviceTools appVersion]);
    NSLog(@"%@",[YHDeviceTools appBuildVersion]);
    NSLog(@"%@",[YHDeviceTools deviceSerialNum]);
    NSLog(@"%@",[YHDeviceTools uuid]);
    NSLog(@"%@",[YHDeviceTools deviceNameDefineByUser]);
    NSLog(@"%@",[YHDeviceTools deviceName]);
    NSLog(@"%@",[YHDeviceTools deviceSystemVersion]);
    NSLog(@"%@",[YHDeviceTools deviceModel]);
    NSLog(@"%@",[YHDeviceTools deviceLocalModel]);
    NSLog(@"%@",[YHDeviceTools operatorInfo]);
    NSLog(@"%ld",[YHDeviceTools batteryState]);
    NSLog(@"%f",[YHDeviceTools batteryLevel]);
}

- (void)testDate {

    NSLog(@"%@",[NSDate getCurrentDateStamp]);
    NSLog(@"%@",[NSDate getCurrentTimeByFormat:@"yyyy-MM-dd HH:mm:ss:SSS"]);
    YHDate *date = [NSDate getStartEndDateStampOfDate:[NSDate date] type:NSCalendarUnitWeekOfYear];
    NSLog(@"%@,%@",date.startDate,date.endDate);
    NSLog(@"%@",[NSDate getDateTimeOfDateStamp:date.startDate format:@"yyyy-MM-dd HH:mm:ss:SSS"]);
    NSLog(@"%@",[NSDate getDateTimeOfDateStamp:date.endDate format:@"yyyy-MM-dd HH:mm:ss:SSS"]);
}

#pragma mark - YHLoggerHandle

- (void)showAllNormalLogFilePath:(NSArray *)filePathList {

    DDLogVerbose(@"%@",filePathList);
}

- (void)showALLCrashLogFilePath:(NSArray *)filePathList {

    DDLogVerbose(@"%@",filePathList);
}

- (void)oneNewCrashLogFileAvaliable:(NSString *)filePath {

    DDLogVerbose(@"%@",filePath);
}


@end
