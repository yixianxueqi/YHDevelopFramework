//
//  RegularCheck.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/27.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "RegularCheck.h"
#import <RegexKitLite/RegexKitLite.h>
//正则匹配的实体
@interface RegexResult : NSObject
/**
 *  匹配到的字符串
 */
@property (nonatomic, copy) NSString *string;

/**
 *  匹配到的字符串的范围
 */
@property (nonatomic, assign) NSRange range;
@end

@implementation RegexResult
@end

@implementation RegularCheck

+ (BOOL)checkWithRegularExpression:(NSString *)expression withString:(NSString *)string {
    
    if (string.length <= 0) {
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression];
    
    return  [predicate evaluateWithObject:string];
}

//查找
+ (NSMutableArray *)findStrWithSuperStr:(NSString *)text RegularExpression:(NSString *)expression
{
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    
    [text enumerateStringsMatchedByRegex:expression usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        RegexResult *rr = [[RegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        [regexResults addObject:rr];
    }];
    
    return regexResults;
}

//②分割
+ (NSMutableArray *)separatedStrWithSuperStr:(NSString *)text RegularExpression:(NSString *)expression
{
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    
    [text enumerateStringsSeparatedByRegex:expression usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        RegexResult *rr = [[RegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        [regexResults addObject:rr];
        
        NSLog(@"%@ -%@",*capturedStrings,NSStringFromRange(rr.range));
        
    }];
    return regexResults;
}

#pragma mark - ********************校验字符串************************
//校验用户名
+ (BOOL)checkUserName:(NSString *)userName {
    
    //只含有汉字、数字、字母、下划线，下划线位置不限
    NSString *regex = @"^[a-zA-Z0-9_\u4e00-\u9fa5]+$";
    
    return [self checkWithRegularExpression:regex withString:userName];
}

//校验用户名
+ (BOOL)checkUserNameWith_:(NSString *)userName
{
    //只含有汉字、数字、字母、下划线不能以下划线开头和结尾
    NSString *regex = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_\\u4e00-\\u9fa5]+$";
    
    return [self checkWithRegularExpression:regex withString:userName];
    
}

//校验邮箱
+ (BOOL)checkEmail:(NSString *)email {
    
    //验证类似 3289@qq.com  或者 3289@qq.vip.cn
    
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+(\\.[A-Za-z]{2,4})+";
    
    //如果失败请用下面的方法
    //@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}||[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}+\\.[A-Za-z]{2,4}]";
    
    return [self checkWithRegularExpression:regex withString:email];
    
}

//校验密码
+ (BOOL)checkPassword:(NSString *)pwd {
    
    //允许包含字母、数字、下划线、*、#
    NSString *regex = @"(^[A-Za-z0-9_*#]{0,15}$)";
    
    return [self checkWithRegularExpression:regex withString:pwd];
}

//校验电话号
+ (BOOL)checkTelephoneNum:(NSString *)tel {
    
    NSString *phoneRegex = @"^(\\d{3,4}-)\\d{7,8}$";
    return [self checkWithRegularExpression:phoneRegex withString:tel];
}

//校验手机号
+ (BOOL)checkMobilephoneNum:(NSString *)tel
{
    //手机号以13， 15，17，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    
    return [self checkWithRegularExpression:phoneRegex withString:tel];
}

+ (BOOL)checkFax:(NSString *)fax {
    
    NSString *faxRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    //@"/^((0\\d{2,3}-)?\\d{7,8})$/";
    //@"/^[+]{0,1}(\\d){1,3}[ ]?([-]?((\\d)|[ ]){1,12})+$/";
    
    return [self checkWithRegularExpression:faxRegex withString:fax];
}

+ (BOOL)validateNoCharacterChar:(NSString *)string {
    
    NSString *regex = @"^[A-Za-z0-9\u4e00-\u9fa5_-]+$";
    
    return [self checkWithRegularExpression:regex withString:string];
}

+ (BOOL)checkURL:(NSString *)str {
    
    NSString *regex = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
    //[a-zA-z]+://[^\s]*
    //评注：网上流传的版本功能很有限，上面这个基本可以满足需求
    return [self checkWithRegularExpression:regex withString:str];
}

//检测身份证号
+ (BOOL)checkIDCard:(NSString *)str {
    
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self checkWithRegularExpression:regex withString:str];
}

//检测是否是QQ号
+ (BOOL)checkQQNumber:(NSString *)str {
    //腾讯QQ号从10 000 开始
    NSString *regex = @"[1-9][0-9]{5,9}";//[1-9][0-9]\{4,\}
    return [self checkWithRegularExpression:regex withString:str];
}

//车牌号验证
+ (BOOL)checkCarNo:(NSString *)carNo
{
    NSString *regex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    return [self checkWithRegularExpression:regex withString:carNo];
}

//检测邮政编码
+ (BOOL)checkPostalCode:(NSString *)str {
    NSString *regex = @"[1-9]\\d{5}(?!\\d)";
    
    return [self checkWithRegularExpression:regex withString:str];
}

//检测IP地址
+ (BOOL)checkIPAddress:(NSString *)str {
    NSString *regex = @"^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$";
    //((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)
    return [self checkWithRegularExpression:regex withString:str];
    //附 更多 参照 http://c.biancheng.net/cpp/html/1437.html
}

// 年-月-日:
+ (BOOL)checkYMD:(NSString *)str
{
    NSString *regex = @"^((((1[6-9]|[2-9]\\d)\\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\\d|3[01]))|(((1[6-9]|[2-9]\\d)\\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\\d|30))|(((1[6-9]|[2-9]\\d)\\d{2})-0?2-(0?[1-9]|1\\d|2[0-8]))|(((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$";
    
    // 更多参照 http://www.cnblogs.com/jay-xu33/archive/2009/01/08/1371953.html
    return [self checkWithRegularExpression:regex withString:str];
}

#pragma mark ********************字母有关************************
//只能输入由数字和26个英文字母下划线组成的字符串
+ (BOOL)checkNumberAndCharacterChar:(NSString *)str
{
    NSString *regex = @"^[0-9a-zA-Z_]{1,}$";
    return [self checkWithRegularExpression:regex withString:str];
    
    //1.由数字、26个英文字母的字符串:
    //^[0-9a-zA-Z]{1,}$
}

//匹配帐号是否合法 (字母开头，允许5-16字节，允许字母数字下划线)
+ (BOOL)checkAccount:(NSString *)str
{
    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9_]{4,15}$";
    return [self checkWithRegularExpression:regex withString:str];
}

//检测匹配空行
+ (BOOL)checkNewlineCharacterSet:(NSString *)str
{
    NSString *regex = @"\\n[\\s| ]*\\r";
    return [self checkWithRegularExpression:regex withString:str];
}

//匹配首尾空白字符的正则表达式：^\s*|\s*$
+ (BOOL)checkWhitespace:(NSString *)str
{
    NSString *regex = @"^\\s*|\\s*$";
    return [self checkWithRegularExpression:regex withString:str];
}

//匹配是否含有^%&',;=?$\"等字符：。
+ (BOOL)checkSpecialCharacter:(NSString *)str
{
    NSString *regex = @"[-\\[\\]~`!@#$%^&*()_+=|}{:;'/?,.\"\\\\]*";
    return [self checkWithRegularExpression:regex withString:str];
}

//2~4个汉字
+ (BOOL)checkMaxFourChinese:(NSString *)str
{
    NSString *regex = @"^[\\u4e00-\\u9fa5]{2,4}$";
    return [self checkWithRegularExpression:regex withString:str];
    
    //只能输入汉字："^[\u4e00-\u9fa5]{0,}$"
}

//匹配双字节字符(包括汉字在内)[^/x00-/xff]
+ (BOOL)checkDoubleByte:(NSString *)str
{
    NSString *regex = @"[^\\x00-\\xff]";
    return [self checkWithRegularExpression:regex withString:str];
}

//验证首字母大写@"\b[^\\Wa-z0-9_][^\\WA-Z0-9_]*\\b"
+ (BOOL)checkFirstCharacterIsUppercaseString:(NSString *)str
{
    NSString *regex = @"^[A-Z][a-zA-Z0-9]{0,}$";
    return [self checkWithRegularExpression:regex withString:str];
}
#pragma mark ********************数字有关************************

+ (BOOL)isNumberText:(NSString *)string {
    
    NSString *regex = @"^[0-9]*$";
    
    return [self checkWithRegularExpression:regex withString:string];
}
+ (BOOL)isNumberOrFloatText:(NSString *)string {
    
    //    NSString * regex = @"^[0-9]+([.]{0}|[.]{1}[0-9]+)$";
    
    NSString *regex = @"^[0-9]+[.]{0,1}[0-9]{0,1}$";
    
    return [self checkWithRegularExpression:regex withString:string];
}

//只能输入有两位小数的正实数：^[0-9]+(.[0-9]{2})?$
+ (BOOL)checkOnlyTwoRealNumber:(NSString *)str
{
    NSString *regex = @"^[0-9]+(.[0-9]{2})?$";
    
    return [self checkWithRegularExpression:regex withString:str];
    // 只能输入有1~3位小数的正实数： ^[0-9]+(.[0-9]{1,3})?$
}

// 只能输入n位的数字：
+ (BOOL)checkNumberWithCount:(NSString *)str
{
    NSString *regex = @"^\\d{6}$";
    
    return [self checkWithRegularExpression:regex withString:str];
}

// 只能输入至少n位的数字：^/d{n,}$
+ (BOOL)checkNumberWithMinCount:(NSString *)str
{
    NSString *regex = @"^\\d{6,}$";
    // 只能输入m~n位的数字： ^\\d{m,n}$
    return [self checkWithRegularExpression:regex withString:str];
}

#pragma mark - ********************抽取字符串************************
//抽取电话号码
+ (NSMutableArray *)findMobileNumberWithStr:(NSString *)text
{
    //匹配电话号码
    NSString *regex = @"((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}";
    
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [self findStrWithSuperStr:text RegularExpression:regex];
    
    return regexResults;
}

//抽取 @和@后面的字符，直到遇到空格为止
+ (NSMutableArray *)findAtStrWithStr:(NSString *)text
{
    //匹配@并且@后面可有n个字符（不包含空格）
    NSString *regex = @"@\\w+";
    
    NSMutableArray *regexResults = [self findStrWithSuperStr:text RegularExpression:regex];
    
    return regexResults;
}

//抽取 双#及其之间的内容
+ (NSMutableArray *)findSymbolWithStr:(NSString *)text
{
    //匹配# #
    NSString *regex = @"#\\w+#";
    
    NSMutableArray *regexResults = [self findStrWithSuperStr:text RegularExpression:regex];
    
    return regexResults;
}

//抽取超链接
+ (NSMutableArray *)findURLStrWithStr:(NSString *)text
{
    //匹配超链接:1，?表示匹配1次或0次。超链接的匹配是根据链接复杂度而定的。
    NSString *regex  = @"http(s)?://([A-Za-z0-9.?_-]+(/)?)*";
    
    NSMutableArray *regexResults = [self findStrWithSuperStr:text RegularExpression:regex];
    
    return regexResults;
}

//抽取验证码
+ (NSMutableArray *)findCodeWithStr:(NSString *)text
{
    //验证码
    NSString *regex  = @"[0-9]{6}$";
    
    NSMutableArray *regexResults = [self findStrWithSuperStr:text RegularExpression:regex];
    
    return regexResults;
}

//抽取邮箱
+ (NSMutableArray *)findMailWithStr:(NSString *)text
{
    //匹配邮箱
    NSString *regex  = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSMutableArray *regexResults = [self findStrWithSuperStr:text RegularExpression:regex];
    
    return regexResults;
}

//分割- 单词
+ (NSMutableArray *)separatedByRegexForStr:(NSString *)text
{
    //用@"main|if" 分割
    NSString *regex = @"main|if";
    
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [self separatedStrWithSuperStr:text RegularExpression:regex];
    return regexResults;
}

//分割- 邮箱
+ (NSMutableArray *)separatedMailByRegexForStr:(NSString *)text
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [self separatedStrWithSuperStr:text RegularExpression:regex];
    return regexResults;
}

//分割- 电话
+ (NSMutableArray *)separatedMobilePhoneByRegexForStr:(NSString *)text
{
    
    NSString *regex =  @"((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}";
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [self separatedStrWithSuperStr:text RegularExpression:regex];
    return regexResults;
}

//分割- #....#
+ (NSMutableArray *)separatedSymbolByRegexForStr:(NSString *)text
{
    NSString *regex =  @"#\\w+#";
    
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [self separatedStrWithSuperStr:text RegularExpression:regex];
    return regexResults;
}

//分割- @
+ (NSMutableArray *)separatedAtByRegexForStr:(NSString *)text
{
    //用@"main|if" 分割
    NSString *regex =  @"@\\w+";
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [self separatedStrWithSuperStr:text RegularExpression:regex];
    return regexResults;
}

//分割- 网址
+ (NSMutableArray *)separatedURLByRegexForStr:(NSString *)text
{
    NSString *regex =  @"http(s)?://([A-Za-z0-9.?_-]+(/)?)*";
    
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [self separatedStrWithSuperStr:text RegularExpression:regex];
    return regexResults;
}

//分割- 验证码
+ (NSMutableArray *)separatedCodeURLByRegexForStr:(NSString *)text
{
    NSString *regex = @"[0-9]{6}$";
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [self separatedStrWithSuperStr:text RegularExpression:regex];
    return regexResults;
}

//替换
+ (NSString *)replaceWithString:(NSString *)replaceStr oldStr:(NSString *)oldStr
{
    //    NSString *test = @"我在#话题#上课@麻子 你们@罗 在听吗？https://www.baidu.com";
    //匹配@并且@后面可有n个字符（不包含空格）
    //NSString *regex = @"@\\w+";
    
    //匹配#
    //NSString *regex = @"#\\w+#";
    
    //匹配超链接:1，?表示匹配1次或0次。超链接的匹配是根据链接复杂度而定的。
    //NSString *regex  = @"http(s)?://([A-Za-z0-9.?_-]+(/)?)*";
    
    //把以上3个合成一个：使用或|隔开，每隔小单元格用小括号包含（注意：这个regex根据自己需求做修改）
    NSString *regex = @"(@\\w+)|(#\\w+#)|(http(s)?://([A-Za-z0-9.?_-]+(/)?)*)";
    
    NSArray *regexArray = [oldStr componentsMatchedByRegex:regex];
    
    for (NSString *s in regexArray)
    {
        //字符串替换
        NSString *target = [NSString stringWithFormat:@"%@",replaceStr];
        oldStr = [oldStr stringByReplacingOccurrencesOfString:s withString:target];
    }
    
    return oldStr;
}

// 将第一个比对出来的结果加入NSArray
+ (NSArray *)findFirstStrWithSuperStr:(NSString *)text RegularExpression:(NSString *)expression
{
    //    NSString *regex = @"@\\w+";
    NSArray *array = [text captureComponentsMatchedByRegex:expression];
    return array;
}


+ (NSString *)findFirstMatchedStrWithSuperStr:(NSString *)text RegularExpression:(NSString *)expression
{
    //    NSString *regex = @"@\\w+";
    NSString *regexResult = [text stringByMatching:expression];
    return regexResult;
}

// 判断字符串是否与Regex配对
+ (BOOL)isMatchedForSuperStr:(NSString *)text regexString:(NSString *)regexString
{
    
    return [self checkWithRegularExpression:regexString withString:text];
    //同下方法
    //return [text isMatchedByRegex:regexString];
}

// 如果是NSMutableString，则可以直接替换，并返回替换的次数
+ (NSInteger)getReplaceCountWithMutableStr:(NSMutableString *)mutString replaceString:(NSString *)replaceString RegularExpression:(NSString *)expression
{
    //mutString = [NSMutableString stringWithString:@"我正在#话题#吃放@zhangsan 你@lisi 吃了没?"];
    //NSString *expression = @"@\\w+";
    NSInteger count = [mutString replaceOccurrencesOfRegex:expression withString:replaceString];
    
    return count;
}

@end
