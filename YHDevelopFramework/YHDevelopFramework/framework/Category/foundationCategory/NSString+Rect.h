//
//  NSString+Rect.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/5.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Rect)

//获取文本宽度
- (CGFloat)stringHeightForWidth:(CGFloat)width fontSize:(CGFloat)size;
//获取文本高度
- (CGFloat)stringWidthForHeight:(CGFloat)height fontSize:(CGFloat)size;

@end
