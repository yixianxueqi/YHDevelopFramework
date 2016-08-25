//
//  InternationalControl.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/27.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

//国际化语言调用宏
#define LocalLanguage(key,annotate) [YHInternationalControl localString:(key) Annotate:(annotate)]
// 简便国际化语言调用宏
#define LLanguage(key) LocalLanguage(key,nil)
//语言变更通知
#define LanguageChangeNotifiacation @"LocalLanguageChangeNotification"
//资源文件名字
//中文
#define LanguageZHCN @"ZHCN_Language"
//英文
#define LanguageEN @"EN_Language"

//语言类型枚举
typedef NS_ENUM(NSUInteger,LanguageEnum) {

    LanguageEnum_ZHCN = 1,
    LanguageEnum_EN,
    
};
/**
 * @class  InternationalControl
 *
 * @abstract 语言国际化
 *
 */
@interface YHInternationalControl : NSObject

+ (instancetype)shareLanguageControl;
//设置语言
- (void)setLanguage:(LanguageEnum)index;
//获取语言
- (LanguageEnum)getLanguage;
//获取本地化语言
+ (NSString *)localString:(NSString *)key Annotate:(NSString *)annotate;

@end
