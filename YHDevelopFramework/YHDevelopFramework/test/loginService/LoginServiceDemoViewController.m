//
//  LoginServiceDemoViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 17/2/14.
//  Copyright © 2017年 isoftstone. All rights reserved.
//

#import "LoginServiceDemoViewController.h"
#import "LoginService.h"

@interface LoginServiceDemoViewController ()

@property (nonatomic, strong) LoginService *loginService;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginServiceDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",NSHomeDirectory());
    self.loginService = [LoginService defaultManager];
}

- (IBAction)login:(UIButton *)sender {
    
    if (self.nameTextField.text.length == 0 || self.passwordTextField.text == 0) {
        NSLog(@"不能为空!");
        return;
    }
    [self.loginService saveLoginInfo:@{@"name":self.nameTextField.text,@"password":self.passwordTextField.text} loginResult:@{@"loginToken":@"loginToken"}];
}

- (IBAction)logout:(UIButton *)sender {
    
    [self.loginService replaceLoginState];
}
- (IBAction)currentLoginInfo:(UIButton *)sender {
    
    NSDictionary *dic = [self.loginService getcurrentLoginInfo];
    NSLog(@"current loginInfo: %@",dic);
}
- (IBAction)historyInfo:(UIButton *)sender {
    
    NSArray *list = [self.loginService getHistoryListCount:0];
    NSLog(@"historyInfo: %@",list);
}
- (IBAction)clear:(UIButton *)sender {
    
    [self.loginService clear];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}


@end
