//
//  DownloadCell.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/18.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "DownloadCell.h"

@interface DownloadCell ()

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation DownloadCell

- (void)awakeFromNib {

    [super awakeFromNib];
    self.contentView.userInteractionEnabled = NO;
}

- (IBAction)clickDoBtn:(UIButton *)sender {
    if (self.block) {
        self.block(incidentDoBtn);
    }
}
- (IBAction)clickCancelBtn:(UIButton *)sender {
    if (self.block) {
        self.block(incidentCancel);
    }
}


@end
