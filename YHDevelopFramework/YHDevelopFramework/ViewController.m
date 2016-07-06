//
//  ViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/6.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+YHDateFormat.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%s",__func__);
    
    NSLog(@"%@",[NSDate getCurrentDateStamp]);
    NSLog(@"%@",[NSDate getCurrentTimeByFormat:@"yyyy-MM-dd HH:mm:ss:SSS"]);
    YHDate *date = [NSDate getStartEndDateStampOfDate:[NSDate date] type:NSCalendarUnitWeekOfYear];
    NSLog(@"%@,%@",date.startDate,date.endDate);
    NSLog(@"%@",[NSDate getDateTimeOfDateStamp:date.startDate format:@"yyyy-MM-dd HH:mm:ss:SSS"]);
    NSLog(@"%@",[NSDate getDateTimeOfDateStamp:date.endDate format:@"yyyy-MM-dd HH:mm:ss:SSS"]);
}


@end
