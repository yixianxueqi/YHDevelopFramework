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
    [self testLogger];
    [self testYYModel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.igv1 circleBorder];
    [self.igv2 cornerBorder:5];
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
