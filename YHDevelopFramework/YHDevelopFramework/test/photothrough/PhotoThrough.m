//
//  PhotoThrough.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/14.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "PhotoThrough.h"
#import "YHPhotoThroughViewController.h"

@interface PhotoThrough ()<YHPhotoThroughDelegate>

@end

@implementation PhotoThrough

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [super touchesBegan:touches withEvent:event];
    YHPhotoThroughViewController *photoThrough = [[YHPhotoThroughViewController alloc] init];
    photoThrough.delegate = self;
    NSMutableArray *tempList = [NSMutableArray array];
    for (int i = 1; i < 6; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [tempList addObject:img];
    }
    photoThrough.imageList = tempList;
    [self presentViewController:photoThrough animated:YES completion:nil];
}

#pragma mark - YHPhotoThroughDelegate

- (void)touchSigleViewIncident {

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
