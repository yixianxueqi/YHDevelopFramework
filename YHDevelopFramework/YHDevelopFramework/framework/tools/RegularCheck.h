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

#pragma mark - 校验字符串
//校验用户名（只含有汉字、数字、字母、下划线，下划线位置不限）
+ (BOOL)checkUserName:(NSString *)userName;

//校验用户名（只含有汉字、数字、字母、下划线不能以下划线开头和结尾）
+ (BOOL)checkUserNameWith_:(NSString *)userName;

//校验邮箱
+ (BOOL)checkEmail:(NSString *)email;

//校验密码
+ (BOOL)checkPassword:(NSString *)pwd;

//校验电话号
+ (BOOL)checkTelephoneNum:(NSString *)tel;

//校验手机号
+ (BOOL)checkMobilephoneNum:(NSString *)tel;

//检测传真格式是否正确
+ (BOOL)checkFax:(NSString *)fax;

//检测字符串是否为纯数字
+ (BOOL)isNumberText:(NSString *)string;

//检测除_与-之外的特殊字符是否存在
+ (BOOL)validateNoCharacterChar:(NSString *)string;

//检查是否是数字或者浮点数
+ (BOOL)isNumberOrFloatText:(NSString *)string;

//检测是否是URL
+ (BOOL)checkURL:(NSString *)str;

//检测身份证号
+ (BOOL)checkIDCard:(NSString *)str;

//检测是否是QQ号
+ (BOOL)checkQQNumber:(NSString *)str;

//车牌号验证
+ (BOOL)checkCarNo:(NSString *)carNo;

//检测邮政编码
+ (BOOL)checkPostalCode:(NSString *)str;

//检测IP地址
+ (BOOL)checkIPAddress:(NSString *)str;

//检测只能输入由数字和26个英文字母、下划线组成的字符串
+ (BOOL)checkNumberAndCharacterChar:(NSString *)str;

//验证首字母大写
+ (BOOL)checkFirstCharacterIsUppercaseString:(NSString *)str;

//检测匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)
+ (BOOL)checkAccount:(NSString *)str;

//检测匹配空行
+ (BOOL)checkNewlineCharacterSet:(NSString *)str;

//匹配首尾空白字符
+ (BOOL)checkWhitespace:(NSString *)str;

//匹配是否含有^%&',;=?$\"等字符："[^%&',;=?$\x22]+"。
+ (BOOL)checkSpecialCharacter:(NSString *)str;

//2~4个汉字
+ (BOOL)checkMaxFourChinese:(NSString *)str;

//匹配双字节字符(包括汉字在内)[^/x00-/xff]
+ (BOOL)checkDoubleByte:(NSString *)str;

//匹配年-月-日:
+ (BOOL)checkYMD:(NSString *)str;

//只能输入有两位小数的正实数：
+ (BOOL)checkOnlyTwoRealNumber:(NSString *)str;

// 只能输入n位的数字：
+ (BOOL)checkNumberWithCount:(NSString *)str;

// 只能输入至少n位的数字：^/d{n,}$
+ (BOOL)checkNumberWithMinCount:(NSString *)str;

// 判断字符串是否与Regex配对
+ (BOOL)isMatchedForSuperStr:(NSString *)text regexString:(NSString *)regexString;

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
