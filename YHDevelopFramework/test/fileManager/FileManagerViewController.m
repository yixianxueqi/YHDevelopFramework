//
//  FileManagerViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "FileManagerViewController.h"
#import "YHFileManager.h"
#import "NSString+Rect.h"

@interface TempModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *detail;
@property (nonatomic,assign) CGFloat height;

@end
@implementation TempModel

+ (instancetype)modelWithName:(NSString *)name detail:(NSString *)detail {

    TempModel *model = [[self alloc] init];
    model.name = name;
    model.detail = detail;
    model.height = [detail stringHeightForWidth:[UIView screenWidth]-40 fontSize:11.0] + 30;
    return model;
}

@end
#pragma mark - FileManagerViewController
@interface FileManagerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *list;

@end

@implementation FileManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DDLogVerbose(@"%@",NSHomeDirectory());
}

- (IBAction)clickBtn:(UIButton *)sender {
    
    if (sender.tag == 1001) {
        //压缩
        [self zip];
    } else {
        //解压缩 1002
        [self unZip];
    }
}
//压缩
- (void)zip {

    YHFileManager *manager = [[YHFileManager alloc] init];
    NSString *path = [YHFileManager tmpPath];
    NSString *fileName = @"3.txt";
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    [manager isExistAtPath:filePath type:FileTypeFile];
    [YHFileManager zipArchiveFolderWithPath:path toPath:path fileName:@"23" pwd:nil];
}
//解压缩
- (void)unZip {
    
    YHFileManager *manager = [[YHFileManager alloc] init];
    NSString *path = [YHFileManager tmpPath];
    NSString *dirPath = [NSHomeDirectory() stringByAppendingPathComponent:@"yh"];
    [manager isExistAtPath:dirPath type:FileTypeDirectory];
    [YHFileManager unzipOpenFileWithPath:[path stringByAppendingPathComponent:@"23.zip"] toPath:dirPath pwd:nil];
}

#pragma mark - tableView delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    TempModel *model = self.list[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.detail;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11.0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    TempModel *model = self.list[indexPath.row];
    return model.height;
}

#pragma mark - getter/setter
- (NSMutableArray *)list {

    if (!_list) {
        _list = [NSMutableArray array];
        [_list addObject:[TempModel modelWithName:@"documentsPath" detail:[YHFileManager documentsPath]]];
        [_list addObject:[TempModel modelWithName:@"libraryPath" detail:[YHFileManager libraryPath]]];
        [_list addObject:[TempModel modelWithName:@"tmpPath" detail:[YHFileManager tmpPath]]];
        [_list addObject:[TempModel modelWithName:@"cachesPath" detail:[YHFileManager cachesPath]]];
        [_list addObject:[TempModel modelWithName:@"preferencesPath" detail:[YHFileManager preferencesPath]]];
    }
    return _list;
}

@end
