//
//  YHTextView.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/28.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^regularLengthResultBlock)(NSInteger);

@interface YHTextView : UITextView

@property (nonatomic, assign) NSInteger regularLength;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, copy) NSString *regularRule;
@property (nonatomic, copy) regularLengthResultBlock resultBlock;

@end
