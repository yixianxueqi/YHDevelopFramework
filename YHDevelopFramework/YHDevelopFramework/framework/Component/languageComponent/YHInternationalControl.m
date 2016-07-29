//
//  InternationalControl.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/27.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#define kLanguageType @"LanguageType"

#import "YHInternationalControl.h"

@interface YHInternationalControl ()


@end

@implementation YHInternationalControl

static YHInternationalControl *control;
+ (instancetype)shareLanguageControl {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [[self alloc] init];
        [control customLanguage];
    });
    return control;
}

- (void)customLanguage {

    //默认中文
    NSInteger index = [self getLanguage];
    if (index == 0 || !index) {
        [self setLanguage:LanguageEnum_ZHCN];
    }
}

//获取本地化语言
+ (NSString *)localString:(NSString *)key Annotate:(NSString *)annotate {

    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:kLanguageType];
    
    if (index == LanguageEnum_ZHCN) {
        //中文
        return NSLocalizedStringFromTableInBundle(key, LanguageZHCN, [NSBundle mainBundle], annotate);
    } else if (index == LanguageEnum_EN) {
        //英文
        return NSLocalizedStringFromTableInBundle(key, LanguageEN, [NSBundle mainBundle], annotate);
    }
    return nil;
}

- (void)setLanguage:(LanguageEnum)index {

    //当设置的语言不等于当前语言时，记录当前的新语言版本，并发送语言变更通知
    if (!(index == [self getLanguage])) {
        [[NSUserDefaults standardUserDefaults] setInteger:index forKey:kLanguageType];
        [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChangeNotifiacation object:[NSNumber numberWithInteger:index]];
    }
}

- (LanguageEnum)getLanguage {

    return [[NSUserDefaults standardUserDefaults] integerForKey:kLanguageType];
}

@end
