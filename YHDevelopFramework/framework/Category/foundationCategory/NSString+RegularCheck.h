//
//  NSString+RegularCheck.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/29.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularCheck)

- (BOOL)regularCheck:(NSString *)rule;

@end

/*
    RegularRule
 */
//校验用户名 - 只含有汉字、数字、字母、下划线，下划线位置不限
extern NSString *const yh_userName;
//校验用户名 - 只含有汉字、数字、字母、下划线不能以下划线开头和结尾
extern NSString *const yh_userName2;
/*
 校验邮箱
 验证类似 3289@qq.com  或者 3289@qq.vip.cn
 如果失败请用 email2
 */
extern NSString *const yh_email;
//校验邮箱
extern NSString *const yh_email2;
//校验密码 - 允许包含字母、数字、下划线、*、#
extern NSString *const yh_password;
//校验电话号 -
extern NSString *const yh_telPhone;
//校验手机号 - 手机号以13， 15，17，18开头，八个 \d 数字字符
extern NSString *const yh_mobilPhone;
//检测传真格式 -
extern NSString *const yh_fax;
//校验纯数字
extern NSString *const yh_number;
//检查是否是数字或者浮点数
extern NSString *const yh_floatNumber;
//检测除_与-之外的特殊字符是否存在
extern NSString *const yh_regex;
//检测是否是URL
extern NSString *const yh_url;
//检测身份证号
extern NSString *const yh_idCard;
//检测是否是QQ号 - 腾讯QQ号从10 000 开始
extern NSString *const yh_qq;
//车牌号验证
extern NSString *const yh_carNumber;
//检测邮政编码
extern NSString *const yh_postNumber;
//检测IP地址
extern NSString *const yh_ipNumber;
//检测只能输入由数字和26个英文字母、下划线组成的字符串
extern NSString *const yh_varStr;
//验证首字母大写
extern NSString *const yh_firstUpper;
//检测匹配帐号是否合法 - 字母开头，允许5-16字节，允许字母数字下划线
extern NSString *const yh_account;
//检测匹配空行
extern NSString *const yh_spaceLine;
//匹配首尾空白字符
extern NSString *const yh_spaceInHeaderTail;
//匹配是否含有^%&',;=?$\"等字符：。
extern NSString *const yh_special;
//2~4个汉字
extern NSString *const yh_twoFourChinese;
//匹配年-月-日
extern NSString *const yh_formatDate;
//只能输入有两位小数的正实数
extern NSString *const yh_twoSpitNumber;
//只能输入1~6位的数字
extern NSString *const yh_oneSixNumber;
//只能输入6位数字
extern NSString *const yh_sixOnlyNumber;
//至少输入6位数字
extern NSString *const yh_sixMoreNumber;

