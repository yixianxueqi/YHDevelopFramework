//
//  ReadMeViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/22.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "ReadMeViewController.h"

@interface ReadMeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ReadMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"readMe" ofType:@"txt"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.textView.text = str;
}


@end
