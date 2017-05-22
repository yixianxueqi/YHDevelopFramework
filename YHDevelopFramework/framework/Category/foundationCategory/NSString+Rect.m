//
//  NSString+Rect.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/5.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NSString+Rect.h"

@implementation NSString (Rect)

//获取文本高度
- (CGFloat)stringHeightForWidth:(CGFloat)width fontSize:(CGFloat)size {

   return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size.height;
}
//获取文本宽度
- (CGFloat)stringWidthForHeight:(CGFloat)height fontSize:(CGFloat)size {

    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size.width;
}

@end
