//
//  DownloadCell.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/18.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "BaseTableViewCell.h"

typedef NS_ENUM(NSUInteger,downloadIncident) {
    
    incidentDoBtn = 1,
    incidentCancel = 2,
};

typedef void(^incidentBlock)(downloadIncident index);

@interface DownloadCell : BaseTableViewCell

@property (nonatomic,copy) incidentBlock block;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *pgView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *doBtn;

@end
