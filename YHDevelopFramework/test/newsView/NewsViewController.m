//
//  NewsViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/24.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NewsViewController.h"
#import "NewContentView.h"

@interface NewsViewController ()

@property (nonatomic,strong) NewContentView *newsView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    self.newsView.frame = CGRectMake(0, 64, self.view.width, self.view.height);
    self.newsView.titleList = @[@"abc",@"cda",@"qwe",@"rew",@"asdadadasd",@"qweqqe",@"ioouou",@"jjhhg"];
}


#pragma mark - getter/setter
- (NewContentView *)newsView {

    if (!_newsView) {
        _newsView = [[NewContentView alloc] init];
        [self.view addSubview:_newsView];
    }
    return _newsView;
}

@end
