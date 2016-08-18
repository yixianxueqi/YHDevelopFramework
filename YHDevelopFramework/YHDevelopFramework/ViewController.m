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
#import "YHDBManager.h"
#import "Person.h"
#import <objc/runtime.h>
#import "NSObject+JsonAndDic.h"
#import "NSNumber+Formatter.h"
#import "NSString+Secret.h"
#import "RegularCheck.h"
#import "YHFileManager.h"
#import "YHNetCache.h"
#import "YHNetWork.h"
#import "Son.h"
#import "NSString+Secret.h"


@interface ViewController ()<YHCrashHandle,YHLoggerHandle>

@property (weak, nonatomic) IBOutlet UIImageView *igv1;
@property (weak, nonatomic) IBOutlet UIImageView *igv2;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%s",__func__);
    [self testLogger];
    DDLogVerbose(@"%@",NSHomeDirectory());
//    [self testDate];
//    [self testDevice];
//    [self testYYModel];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self testHUD];
//    });
//    [self testTools];
//    [self testLanguage];
//    [self testFileManager];
//    [self testYHNetwork];
//    [self testFileMutableDownload];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.igv1 circleBorder];
    [self.igv2 cornerBorder:5];
//    [self testBGView];
//    [self testChildThreadCrash];
//    [self testDB];
//    [self testRuntime];
//    [self testNumberFormatter];
//    [self testRegularAndmd5];

}
- (void)dealloc {

//    [self removeObserver:self forKeyPath:@"list"];
}
#pragma mark - Test

- (void)testYHNetwork {

    YHNetCache *cache = [YHNetCache sharedCache];
//    NSString *get1 = @"http://59.42.254.235:8004/membermgt/mvc/member/queryNeighbourhood.json";
//    NSDictionary *dic1 = @{@"memberId":@"6060"};
//    NSString *get2 = @"http://bea.wufazhuce.com/OneForWeb/one/getHp_N";
//    NSDictionary *dic2 = @{@"strDate":@"2015-05-25",@"strRow":@"1"};
//    NSString *download1 = @"http://dl_dir.qq.com/qqfile/qq/QQforMac/QQ_V2.4.1.dmg";
//    NSString *download2 = @"http://farm3.staticflickr.com/2831/9823890176_82b4165653_b_d.jpg";
    YHNetWork *network = [[YHNetWork alloc] init];
    [YHNetWork setRequestTimeOut:30.f];
    DDLogVerbose(@"Header: %@",[network getAllHeader]);
    DDLogVerbose(@"responseAcceptableType: %@",[network getAllresponseAcceptableContentType]);
    
#if 0
    [YHNetWork setCommonParam:dic1];
    [network POST:get1 parameters:@{} success:^(id responseObj) {
        DDLogVerbose(@"result: %@",responseObj);
    } failure:^(NSError *error) {
        DDLogVerbose(@"error: %@",error);
    }];
#endif
#if 0
    [YHNetWork setCommonParam:dic2];
//    [network isUseCache:YES];
    [network GET:get2 parameters:nil success:^(id responseObj) {
        
        DDLogVerbose(@"result: %@",responseObj);
    } failure:^(NSError *error) {
        DDLogVerbose(@"error: %@",error.localizedDescription);
    }];
#endif
#if 0
    UploadObj *obj = [[UploadObj alloc] init];
//    obj.type = UploadData;
//    obj.fileName = [NSString stringWithFormat:@"%ld",(long)([[NSDate date] timeIntervalSince1970] * 1000)];
//    obj.name = @"file";
//    obj.mimeType = @"image/jpeg";
//    obj.data = UIImageJPEGRepresentation([UIImage imageNamed:@"nodata_zore"], 0.15);
    [network uploadTaskWithUploadObj:obj progress:^(NSProgress *uploadProgress) {
        
        DDLogVerbose(@"%f",uploadProgress.fractionCompleted);
    } completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        NSDictionary *dicJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (error) {
            NSLog(@"error: %@",error);
        } else {
            NSLog(@"responseObject: %@",dicJson);
        }
        
    }];
    
#endif
#if 0
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSURLSessionDownloadTask *task = [network downlaodTaskWithUrl:download2 progress:^(NSProgress *downloadProgress) {
      
        DDLogVerbose(@"progress: %f",downloadProgress.fractionCompleted);
    } destination:filePath completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            DDLogVerbose(@"error:%@",error);
        } else {
            DDLogVerbose(@"complete:filePath:%@",filePath);
        }
    }];
    
#endif
    
}

- (void)testFileManager {

    YHFileManager *manager = [[YHFileManager alloc] init];
    NSString *path = [YHFileManager tmpPath];
    NSString *fileName = @"3.txt";
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    [manager isExistAtPath:filePath type:FileTypeFile];
    NSString *dirPath = [NSHomeDirectory() stringByAppendingPathComponent:@"yh"];
//    NSString *fileName = @"1.txt";
//    [manager isExistAtPath:dirPath type:FileTypeDirectory];
//    [manager isExistAtPath:[dirPath stringByAppendingPathComponent:fileName] type:FileTypeFile];
//    DDLogVerbose(@"%@",[YHFileManager documentsPath]);
//    DDLogVerbose(@"%@",[YHFileManager libraryPath]);
//    DDLogVerbose(@"%@",[YHFileManager tmpPath]);
//    DDLogVerbose(@"%@",[YHFileManager cachesPath]);
//    DDLogVerbose(@"%@",[YHFileManager preferencesPath]);
    [YHFileManager zipArchiveFolderWithPath:path toPath:path fileName:@"23" pwd:nil];
    [YHFileManager unzipOpenFileWithPath:[path stringByAppendingPathComponent:@"23.zip"] toPath:dirPath pwd:nil];
    DDLogVerbose(@"%@",[manager fileNameWithPath:path]);
    [manager clearFile:[path stringByAppendingPathComponent:@"23.zip"]];
    DDLogVerbose(@"%@",[manager fileNameWithPath:path]);
    
}

- (void)testLanguage {

    DDLogVerbose(@"%ld",[[YHInternationalControl shareLanguageControl] getLanguage]);
}

- (void)testRegularAndmd5 {

    DDLogVerbose(@"%@",[@"123" md5]);
    DDLogVerbose(@"%d",[RegularCheck checkEmail:@"yixianxueqiqq.com"]);
}

- (void)testNumberFormatter {

    NSNumber *num1 = @1.5;
    DDLogVerbose(@"%@",[num1 percentageFormatter]);
    NSNumber *num2 = @112345678;
    DDLogVerbose(@"%@",[num2 scienceFormatter]);
}

- (void)testRuntime {

    NSArray *list = [self propertyByClassName:[Person class]];
    DDLogVerbose(@"%@",list);
}

- (void)testDB {

//    YHDBYTKValueStore *stroe = [[[YHDBManager alloc] init] getKeyValueStore];
//    NSString *tableName = @"YTKVS";
//    [stroe createTableWithName:tableName];
//    NSString *keyid = [stroe putObject:[[self per] modelToJSONObject] intoTable:tableName];
//    id pers = [stroe getYTKKeyValueItemById:keyid fromTable:tableName].itemObject;
//    DDLogVerbose(@"%@",pers);
//    NSString *keyID = [stroe putNumber:@2 intoTable:tableName];
//    DDLogVerbose(@"%@",[stroe getNumberById:keyID fromTable:tableName]);
//    [stroe clearTable:tableName];
//    NSArray *list = [stroe getAllItemsFromTable:tableName];
//    for (YTKKeyValueItem *item in list) {
//        
//        DDLogVerbose(@"%@",item.itemObject);
//    }
    NSLog(@"%@",[[[self per] toDic] toJsonString]);
}

- (Person *)per {

    Person *pers = [[Person alloc] init];
    pers.name = @"123";
    pers.age = 21;
    pers.sex = YES;
    pers.dic = @{@"1":@"0"};
    pers.list = @[@"1",@"2",@"3",@"4"];
    return pers;
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

- (void)languageChanged {

    DDLogVerbose(@"viewcontroller 1");

    DDLogVerbose(@"%@",LLanguage(@"gg"));
    [self.btn setTitle:LocalLanguage(@"say",nil) forState:UIControlStateNormal];
}

#pragma mark - btn

- (IBAction)btnClick:(UIButton *)sender {
    
    if ([[YHInternationalControl shareLanguageControl] getLanguage] == 1) {
        [[YHInternationalControl shareLanguageControl] setLanguage:LanguageEnum_EN];
    } else {
        [[YHInternationalControl shareLanguageControl] setLanguage:LanguageEnum_ZHCN];
    }
    [sender setTitle:LocalLanguage(@"say",nil) forState:UIControlStateNormal];
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
