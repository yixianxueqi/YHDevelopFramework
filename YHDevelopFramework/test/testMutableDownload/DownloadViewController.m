//
//  DownloadViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/18.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "DownloadViewController.h"
#import "YHFileDownLoadManager.h"
#import "DownloadCell.h"


#define kDownload1 @"http://dl_dir.qq.com/qqfile/qq/QQforMac/QQ_V2.4.1.dmg"
#define kDownload2 @"http://farm6.staticflickr.com/5505/9824098016_0e28a047c2_b_d.jpg"
#define kDownload3 @"http://farm3.staticflickr.com/2846/9823925914_78cd653ac9_b_d.jpg"
#define kDownload4 @"http://farm3.staticflickr.com/2831/9823890176_82b4165653_b_d.jpg"
#define kDownload5 @"http://download.xitongxz.com/Ylmf_Ghost_Win7_SP1_x64_2016_0512.iso"


@interface DownloadViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) YHFileDownLoadManager *manager;
@property (nonatomic,strong) NSMutableArray *downloadList;

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DDLogVerbose(@"sanBox: %@",NSHomeDirectory());
    regNibCellT(self.tableView, @"DownloadCell", @"cell");
    self.manager = [YHFileDownLoadManager sharedManager];
    NSString *docPath = @"YHFileDownloads";
    NSString *sigleID = [self.manager addTaskWithUrl:kDownload1 saveDirectory:docPath];
    [self.downloadList addObject:sigleID];
    sigleID = [self.manager addTaskWithUrl:kDownload2 saveDirectory:docPath];
    [self.downloadList addObject:sigleID];
    sigleID = [self.manager addTaskWithUrl:kDownload5 saveDirectory:docPath];
    [self.downloadList addObject:sigleID];
    __weak typeof(self) weakSelf = self;
    [self.manager completeBlock:^(YHFileDownLoadModel *model) {
        NSLog(@"finsh: %@",model.absolutePath);
        [weakSelf.downloadList removeObject:model.sigleID];
        [weakSelf.tableView reloadData];
        
    }];
}

#pragma mark - tableView delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.downloadList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *sigleID = self.downloadList[indexPath.row];
    YHFileDownLoadModel *model = [self.manager getFileDownloadModelWithSigleID:sigleID];
    cell.nameLabel.text = model.name;
    __weak typeof(self) weakSelf = self;
    cell.block = ^(downloadIncident index){
        if (index == incidentDoBtn) {
            if (model.status == YHFileDownloadWaiting) {
                [weakSelf.manager startTaskWithSigleID:sigleID];
            } else if (model.status == YHFileDownloaddownload) {
                [weakSelf.manager suspendTaskWithSigleID:sigleID];
            } else if (model.status == YHFileDownloadSuspend) {
                [weakSelf.manager resumeTaskWithSigleID:sigleID];
            }
        } else if (index == incidentCancel) {
            [weakSelf.manager cancelTaskWithSigleID:sigleID];
        }
    };
    [self.manager observeTaskWithSigleID:sigleID block:^(YHFileDownloadStatus status, double progress) {
        cell.pgView.progress = progress;
        cell.statusLabel.text = [NSString stringWithFormat:@"%.2f%%",progress*100];
        if (status == YHFileDownloadWaiting) {
            [cell.doBtn setTitle:@"等待" forState:UIControlStateNormal];
        } else if (status == YHFileDownloaddownload) {
            [cell.doBtn setTitle:@"暂停" forState:UIControlStateNormal];
        } else if (status == YHFileDownloadSuspend) {
            [cell.doBtn setTitle:@"继续" forState:UIControlStateNormal];
        } else if (status == YHFileDownloadFinshed) {
            [cell.doBtn setTitle:@"完成" forState:UIControlStateNormal];
        } else if (status == YHFileDownloadFailure) {
            [cell.doBtn setTitle:@"失败" forState:UIControlStateNormal];
        } else if (status == YHFileDownloadBegin) {
            [cell.doBtn setTitle:@"开始" forState:UIControlStateNormal];
        }
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 88.0;
}

#pragma mark - getter/setter
- (NSMutableArray *)downloadList {

    if (!_downloadList) {
        _downloadList = [NSMutableArray array];
    }
    return _downloadList;
}


@end
