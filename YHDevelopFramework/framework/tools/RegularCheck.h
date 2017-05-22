//
//  RegularCheck.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/27.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @class  <#类名#>
 *
 * @abstract <#这里可以写关于这个类的一些描述。#>
 *
 */
@interface RegularCheck : NSObject


#pragma mark - 抽取字符串 （<!>注意看使用说明）
/**
 *  使用说明：
 *  1. 添加第三方库 RegexKitLite (https://github.com/wezm/RegexKitLite.git)
 *     如果当前工程是ARC环境，需把RegexKitLite.m的编译开关设置为： -fno-objc-arc
 *  2. 导入系统库  libicucore.tbd
 *
 */


#pragma mark 抽取
//按需求匹配存入数组，目前有电话，＃＃， @ ，网址 ，邮箱 ，验证码

//抽取电话号码
+ (NSMutableArray *)findMobileNumberWithStr:(NSString *)text;

//抽取 @和@后面的字符，直到遇到空格为止
+ (NSMutableArray *)findAtStrWithStr:(NSString *)text;

//抽取 双#及其之间的内容 # #
+ (NSMutableArray *)findSymbolWithStr:(NSString *)text;

//抽取超链接（网址）
+ (NSMutableArray *)findURLStrWithStr:(NSString *)text;

//抽取验证码
+ (NSMutableArray *)findCodeWithStr:(NSString *)text;

//抽取邮箱
+ (NSMutableArray *)findMailWithStr:(NSString *)text;

//将抽取的第一个比对出来的结果加入NSArray(自定义规则 expression)
+ (NSArray *)findFirstStrWithSuperStr:(NSString *)text RegularExpression:(NSString *)expression;

// 返回抽取的第一个匹配结果(自定义规则 expression)
+ (NSString *)findFirstMatchedStrWithSuperStr:(NSString *)text RegularExpression:(NSString *)expression;

#pragma mark 分割
// 根据单词分割
+ (NSMutableArray *)separatedByRegexForStr:(NSString *)text;
//根据邮箱分割
+ (NSMutableArray *)separatedMailByRegexForStr:(NSString *)text;
//根据电话分割
+ (NSMutableArray *)separatedMobilePhoneByRegexForStr:(NSString *)text;
//根据双#号（#....#）分割
+ (NSMutableArray *)separatedSymbolByRegexForStr:(NSString *)text;
//根据@符分割（@后可加常规字符，不能包括空格）
+ (NSMutableArray *)separatedAtByRegexForStr:(NSString *)text;
//根据网址（http(s)...）分割
+ (NSMutableArray *)separatedURLByRegexForStr:(NSString *)text;
//根据验证码分割
+ (NSMutableArray *)separatedCodeURLByRegexForStr:(NSString *)text;

#pragma mark - 替换字符串
//替换(注意：自己根据需求 修改正则表达式)
+ (NSString *)replaceWithString:(NSString *)replaceStr oldStr:(NSString *)oldStr;

// 如果是NSMutableString，则可以直接替换，并返回替换的次数 (注意：自己根据需求 修改正则表达式)
+ (NSInteger)getReplaceCountWithMutableStr:(NSMutableString *)mutString replaceString:(NSString *)replaceString RegularExpression:(NSString *)expression;

@end
