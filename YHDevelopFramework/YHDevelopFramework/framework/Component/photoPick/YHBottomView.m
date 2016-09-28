//
//  YHBottomView.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/27.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "YHBottomView.h"

@interface YHBottomView ()

@property (weak, nonatomic) IBOutlet UIButton *certainBtn;
@property (weak, nonatomic) IBOutlet UILabel *preTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectCountLabel;

@end

@implementation YHBottomView

- (void)setSelectCountOfPhoto:(NSUInteger)count {

    if (count == 0) {
        self.selectCountLabel.text = [NSString stringWithFormat:@"%ld",count];
        [self notSelect];
    } else {
        self.selectCountLabel.text = [NSString stringWithFormat:@"%ld",count];
        [self hasSelect];
    }
}
- (IBAction)clickBtn:(UIButton *)sender {
    
    if (self.certainBlock) {
        self.certainBlock();
    }
}

- (void)hasSelect {

    [self.certainBtn setBackgroundColor:[UIColor colorWithRed:0.112 green:0.6971 blue:1.0 alpha:1.0]];
    self.preTitleLabel.textColor = [UIColor darkTextColor];
    self.selectCountLabel.textColor = [UIColor darkTextColor];
    self.endTitleLabel.textColor = [UIColor darkTextColor];
    self.certainBtn.userInteractionEnabled = YES;
}

- (void)notSelect {

    [self.certainBtn setBackgroundColor:[UIColor darkGrayColor]];
    self.preTitleLabel.textColor = [UIColor lightGrayColor];
    self.selectCountLabel.textColor = [UIColor lightGrayColor];
    self.endTitleLabel.textColor = [UIColor lightGrayColor];
    self.certainBtn.userInteractionEnabled = NO;
}

@end
