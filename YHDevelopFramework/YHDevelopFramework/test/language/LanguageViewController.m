//
//  LanguageViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//
/*
    @notice bug: 点击两次才生效（click twice effective）
 */
#import "LanguageViewController.h"

@interface LanguageViewController ()

@property (weak, nonatomic) IBOutlet UIButton *changeBtn;

@end

@implementation LanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DDLogVerbose(@"%ld",[[YHInternationalControl shareLanguageControl] getLanguage]);
    [self.changeBtn setTitle:LLanguage(@"change") forState:UIControlStateNormal];
}

- (IBAction)clickChange:(UIButton *)sender {
    
    LanguageEnum index = [[YHInternationalControl shareLanguageControl] getLanguage];
    if (index == LanguageEnum_ZHCN) {
        [[YHInternationalControl shareLanguageControl] setLanguage:LanguageEnum_EN];
    } else {
        [[YHInternationalControl shareLanguageControl] setLanguage:LanguageEnum_ZHCN];
    }
}

- (void)languageChanged {

    [self.changeBtn setTitle:LLanguage(@"change") forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem setTitle:LLanguage(@"back")];
}

@end
