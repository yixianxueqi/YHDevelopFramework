//
//  BaseNavigationViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "YHInternationalControl.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    self.navigationBar.translucent = YES;
    [self.navigationBar setTintColor:[UIColor blackColor]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count != 0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:LLanguage(@"back") style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back {

    [self popViewControllerAnimated:YES];
}

@end
