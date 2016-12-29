//
//  YHTextField.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/29.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^regularLengthResultBlock)(NSInteger);

@interface YHTextField : UITextField

@property (nonatomic, copy) NSString *regularRule;
@property (nonatomic, assign) NSInteger regularLength;
@property (nonatomic, copy) regularLengthResultBlock resultBlock;

@end
