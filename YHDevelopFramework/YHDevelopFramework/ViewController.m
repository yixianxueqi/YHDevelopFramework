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
#import "YHDBSQLite.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()<YHCrashHandle,YHLoggerHandle>

@property (weak, nonatomic) IBOutlet UIImageView *igv1;
@property (weak, nonatomic) IBOutlet UIImageView *igv2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%s",__func__);
    DDLogVerbose(@"%@",NSHomeDirectory());
//    [self testDate];
//    [self testDevice];
    [self testLogger];
//    [self testYYModel];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self testHUD];
//    });
//    [self testTools];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.igv1 circleBorder];
    [self.igv2 cornerBorder:5];
//    [self testBGView];
//    [self testChildThreadCrash];
//    [self testDB];
    [self testRuntime];
    
}
#pragma mark - Test

- (void)testRuntime {

    NSArray *list = [self propertyByClassName:[Person class]];
    DDLogVerbose(@"%@",list);
}

- (void)testDB {

//    YHDBSQLite *manager = [YHDBSQLite sharedDBManager];
//    [manager doInTransaction:^(FMDatabase *db, BOOL *rollback) {
//        NSString *sql = @"create table bulktest1 (id integer primary key autoincrement, x text);"
//                        "insert into bulktest1 (x) values ('XXX');";
//        BOOL flag = [db executeStatements:sql];
//        DDLogVerbose(@"%d",flag);
//        sql = @"select * from bulktest1;";
//        FMResultSet *s = [db executeQuery:sql];
//        while ([s next]) {
//            NSString *text = [s stringForColumn:@"x"];
//            DDLogVerbose(@"%@",text);
//        }
//    }];
    
}

- (void)testChildThreadCrash {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            @try {
                NSArray *list = @[@"1",@"2",@"3"];
                for (int i = 0; i < 4; i++) {
                    NSLog(@"%@",list[i]);
                }
            } @catch (NSException *exception) {
                DDLogVerbose(@"%@",exception);
            } @finally {
                DDLogVerbose(@"end");
            }
           
        });
    });
}

- (void)testTools {

//    NSString *path = [[NSBundle mainBundle] pathForResource:@"YHLis" ofType:@"plist"];
    NSDictionary *dic = dicFromePlist(@"Info");//[[NSDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"%@",dic);
    NSArray *list = listFromPlist(@"YHList");//[[NSArray alloc] initWithContentsOfFile:path];
    NSLog(@"%@",list);
//    UITableView *tabView = [[UITableView alloc] init];
//    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@""];
}

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
//     DDLogVerbose(@"Verbose");
//     DDLogDebug(@"Debug");
//     DDLogInfo(@"Info");
//     DDLogWarn(@"Warn");
//     DDLogError(@"Error");
//
//    DDLogError(@"************");
//    
//    DDLogVerbose(@"Verbose");
//    DDLogDebug(@"Debug");
//    DDLogInfo(@"Info");
//    DDLogWarn(@"Warn");
//    DDLogError(@"Error");
//    
//    NSArray *list = @[@"1",@"2",@"3",@"4"];
//    for (int i = 0; i < 5; i++) {
//        DDLogVerbose(@"%@",list[i]);
//    }
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
//获取对象的属性名称
- (NSArray *)propertyByClassName:(Class)cls {
    
    NSMutableArray *list = [NSMutableArray array];
    NSMutableArray *nameList = [NSMutableArray array];
    NSMutableArray *typeList = [NSMutableArray array];
    [list addObject:nameList];
    [list addObject:typeList];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        //名称
        const char *propertyName = property_getName(property);
        //类型
        const char *propertyAttribute = property_getAttributes(property);
        
        [nameList addObject:[NSString stringWithUTF8String:propertyName]];
        [typeList addObject:[NSString stringWithUTF8String:propertyAttribute]];
        
    }
    free(properties);
    return list;
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
