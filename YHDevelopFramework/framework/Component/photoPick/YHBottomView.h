//
//  YHBottomView.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/9/27.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BottomViewCertainBlock)(void);

@interface YHBottomView : UIView

@property (nonatomic,copy) BottomViewCertainBlock certainBlock;

- (void)setSelectCountOfPhoto:(NSUInteger)count;

@end
