//
//  UIImage+ChangeSize.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/19.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  改变图片大小
 */
@interface UIImage (ChangeSize)

//按比例压缩图片到指定宽度
- (UIImage *)compressToTargetWidth:(CGFloat)defineWidth;
//img 需要压缩的对象 限制最高数据量KB step每循环一次步进值(0~1.0)
- (NSData *)adjustlimitSize:(NSInteger)size step:(float)delta;

@end
