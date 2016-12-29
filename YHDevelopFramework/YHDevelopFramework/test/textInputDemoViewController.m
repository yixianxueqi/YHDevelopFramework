//
//  textInputDemoViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/29.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "textInputDemoViewController.h"
#import "YHTextView.h"
#import "YHTextField.h"
#import "NSString+RegularCheck.h"

@interface textInputDemoViewController ()

@property (weak, nonatomic) IBOutlet YHTextField *textField;
@property (weak, nonatomic) IBOutlet YHTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation textInputDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.regularLength = 10;
//    self.textView.regularRule = yh_userName;
    self.textView.placeHolder = @"请输入。。。";
    self.textView.resultBlock = ^(NSInteger length){
        DDLogDebug(@"%ld",length);
        self.countLabel.text = [NSString stringWithFormat:@"%ld",length];
    };
    
    self.textField.regularRule = yh_twoSpitNumber;
}

@end
