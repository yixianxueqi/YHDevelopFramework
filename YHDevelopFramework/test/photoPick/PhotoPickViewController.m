//
//  PhotoPickViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/19.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "PhotoPickViewController.h"
#import "YHPhotoPickController.h"

@interface PhotoPickViewController ()

@property (nonatomic,strong) YHPhotoPickController *pickC;

@end

@implementation PhotoPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [super touchesBegan:touches withEvent:event];
    self.pickC = [[YHPhotoPickController alloc] init];
    [self.navigationController pushViewController:self.pickC animated:YES];
}

@end
