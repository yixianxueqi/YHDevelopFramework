//
//  PhotoPickViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/26.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "PhotoPickViewController.h"
#import "YHPhotoPickController.h"

@interface PhotoPickViewController ()

@end

@implementation PhotoPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc {

    NSLog(@"photo pick demo dealloc");
}

- (IBAction)clickBtn:(UIButton *)sender {
    
    YHPhotoPickController *photoPick = [[YHPhotoPickController alloc] init];
    photoPick.maxSelectCount = 3;
    __weak typeof(self) weakSelf = self;
    photoPick.completionBlock = ^(NSArray<UIImage *> *imageList){
    
        NSLog(@"select image finsh: %@",imageList);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:photoPick animated:YES];
}

@end
