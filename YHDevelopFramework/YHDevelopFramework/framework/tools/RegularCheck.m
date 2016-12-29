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
