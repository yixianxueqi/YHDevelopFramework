//
//  FlowViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/23.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "FlowViewController.h"
#import "FlowContentView.h"

@interface FlowViewController ()<FlowItemProtocol>

@property (nonatomic,strong) FlowContentView *flowContentView;

@end

@implementation FlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.flowContentView];
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    self.flowContentView.frame =  CGRectMake(0, 64, self.view.width, self.view.height);
    self.flowContentView.itemList = @[@"sas",@"ads",@"sakjsda",@"adsd",@"tyu",@"sadddd",@"rre",@"asdada",@"asdhajhd",@"123",@"765",@"876",@"oiuy"];
}

#pragma mark - FlowItemProtocol
//自定义按钮属性
- (UIButton *)customButtonAttribute:(UIButton *)button {

    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.borderWidth = 0.5;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor yellowColor]];

    return button;
}
//按钮被点击时
- (void)itemClickIncident:(NSInteger)index {

    NSLog(@"click At Index: %ld",index);
}

#pragma mark - getter/setter
- (FlowContentView *)flowContentView {

    if (!_flowContentView) {
        _flowContentView = [[FlowContentView alloc] init];
        _flowContentView.delegate = self;
    }
    return _flowContentView;
}

@end
