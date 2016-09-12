//
//  NetworkViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NetworkViewController.h"
#import "YHNetWork.h"

#define kHttp1 @"http://59.42.254.235:8004/membermgt/mvc/member/queryNeighbourhood.json"
#define kHttp2 @"http://bea.wufazhuce.com/OneForWeb/one/getHp_N"
#define kHttp3 @"http://dl_dir.qq.com/qqfile/qq/QQforMac/QQ_V2.4.1.dmg"
#define kHttp4 @"http://farm3.staticflickr.com/2831/9823890176_82b4165653_b_d.jpg"

@interface NetworkViewController ()

//tag 1001
@property (weak, nonatomic) IBOutlet UIButton *getBtn;
//tag 1002
@property (weak, nonatomic) IBOutlet UIButton *postBtn;
//tag 1003
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
//tag 1004
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;

@end

@implementation NetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [YHNetWork setRequestTimeOut:15.f];
//    [self requestLKB];
}

- (IBAction)clickBtn:(UIButton *)sender {
    
    if (sender.tag == 1001) {
        [self getHttp];
    } else if (sender.tag == 1002) {
        [self postHttp];
    } else if (sender.tag == 1003) {
        [self downloadHttp];
    } else {
        //1004
        [self uploadHttp];
    }
}

- (void)getHttp {

    YHNetWork *network = [[YHNetWork alloc] init];
    DDLogVerbose(@"Header: %@",[network getAllHeader]);
    DDLogVerbose(@"responseAcceptableType: %@",[network getAllresponseAcceptableContentType]);
    NSDictionary *dic = @{@"strDate":@"2015-05-25",@"strRow":@"1"};
    //设置公共参数
    [YHNetWork setCommonParam:dic];
    //使用缓存
    [network isUseCache:YES];
    [network GET:kHttp2 parameters:dic success:^(id responseObj) {
        DDLogVerbose(@"result: %@",responseObj);
    } failure:^(NSError *error) {
        DDLogVerbose(@"error: %@",error.localizedDescription);
    }];
}

- (void)postHttp {
    
    YHNetWork *network = [[YHNetWork alloc] init];
    DDLogVerbose(@"Header: %@",[network getAllHeader]);
    DDLogVerbose(@"responseAcceptableType: %@",[network getAllresponseAcceptableContentType]);
    //设置kHttp1不使用公共参数
    [YHNetWork blackListNotUseCommonParam:@[kHttp1]];
    [network POST:kHttp1 parameters:nil success:^(id responseObj) {
        DDLogVerbose(@"result: %@",responseObj);
    } failure:^(NSError *error) {
        DDLogVerbose(@"error: %@",error);
    }];
}

- (void)downloadHttp {

    YHNetWork *network = [[YHNetWork alloc] init];
    DDLogVerbose(@"Header: %@",[network getAllHeader]);
    DDLogVerbose(@"responseAcceptableType: %@",[network getAllresponseAcceptableContentType]);
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSURLSessionDownloadTask *task = [network downlaodTaskWithUrl:kHttp4 progress:^(NSProgress *downloadProgress) {
        
        DDLogVerbose(@"progress: %f",downloadProgress.fractionCompleted);
    } destination:filePath completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            DDLogVerbose(@"error:%@",error);
        } else {
            DDLogVerbose(@"complete:filePath:%@",filePath);
        }
    }];

}

- (void)uploadHttp {

    YHNetWork *network = [[YHNetWork alloc] init];
    DDLogVerbose(@"Header: %@",[network getAllHeader]);
    DDLogVerbose(@"responseAcceptableType: %@",[network getAllresponseAcceptableContentType]);
    UploadObj *obj = [[UploadObj alloc] init];
    //自己设置上传接口
    obj.url = @"";
    obj.type = UploadData;
    obj.fileName = [NSString stringWithFormat:@"%ld",(long)([[NSDate date] timeIntervalSince1970] * 1000)];
    obj.name = @"file";
    obj.mimeType = @"image/jpeg";
    obj.data = UIImageJPEGRepresentation([UIImage imageNamed:@"nodata_zore"], 0.15);
    [network uploadTaskWithUploadObj:obj progress:^(NSProgress *uploadProgress) {
        
        DDLogVerbose(@"%f",uploadProgress.fractionCompleted);
    } completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"error: %@",error);
        } else {
            NSDictionary *dicJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"responseObject: %@",dicJson);
        }
        
    }];
}

- (void)requestLKB {

    /*
        http://www.lvkeworld.com/ashx/App.ashx?
     action=getMyDatas&apikey=b6a26fb81b2429e1&userid=521
     */
    NSString *url = @"http://www.lvkeworld.com/ashx/App.ashx";
    NSDictionary *dic = @{@"action":@"getMyDatas",@"apikey":@"b6a26fb81b2429e1",@"userid":@"521"};
    YHNetWork *network = [[YHNetWork alloc] init];
    DDLogVerbose(@"Header: %@",[network getAllHeader]);
    DDLogVerbose(@"responseAcceptableType: %@",[network getAllresponseAcceptableContentType]);
    [YHNetWork blackListNotUseCommonParam:@[kHttp1,url]];
    [network GET:url parameters:dic success:^(id responseObj) {
        DDLogVerbose(@"responseObj: %@",responseObj);
    } failure:^(NSError *error) {
        DDLogVerbose(@"error: %@",error);
    }];

}

@end
