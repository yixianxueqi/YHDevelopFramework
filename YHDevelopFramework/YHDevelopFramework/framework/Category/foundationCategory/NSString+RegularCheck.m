//
//  NSString+RegularCheck.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/12/29.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NSString+RegularCheck.h"

@implementation NSString (RegularCheck)

- (BOOL)regularCheck:(NSString *)rule {

    if (!rule || rule.length <= 0) {
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rule];
    return [predicate evaluateWithObject:self];
}

@end

NSString *const yh_userName = @"^[a-zA-Z0-9_\\u4e00}-\\u9fa5]+$";
NSString *const yh_userName2 = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_\\u4e00-\\u9fa5]+$";
NSString *const yh_email = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+(\\.[A-Za-z]{2,4})+";
NSString *const yh_email2 = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}||[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}+\\.[A-Za-z]{2,4}]";
NSString *const yh_password = @"(^[A-Za-z0-9_*#]{0,15}$)";
NSString *const yh_telPhone = @"^(\\d{3,4}-)\\d{7,8}$";
NSString *const yh_mobilPhone = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
NSString *const yh_fax = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
NSString *const yh_number = @"^[0-9]*$";
NSString *const yh_floatNumber = @"^[0-9]+[.]{0,1}[0-9]{0,1}$";
NSString *const yh_regex = @"^[A-Za-z0-9\\u4e00-\\u9fa5_-]+$";
NSString *const yh_url = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
NSString *const yh_idCard = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
NSString *const yh_qq = @"[1-9][0-9]{5,9}";
NSString *const yh_carNumber = @"^[\\u4e00-\\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\\u4e00-\\u9fa5]$";
NSString *const yh_postNumber = @"[1-9]\\d{5}(?!\\d)";
NSString *const yh_ipNumber = @"^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$";
NSString *const yh_varStr = @"^[0-9a-zA-Z_]{1,}$";
NSString *const yh_firstUpper = @"^[A-Z][a-zA-Z0-9]{0,}$";
NSString *const yh_account = @"^[a-zA-Z][a-zA-Z0-9_]{4,15}$";
NSString *const yh_spaceLine = @"\\n[\\s| ]*\\r";
NSString *const yh_spaceInHeaderTail = @"^\\s*|\\s*$";
NSString *const yh_special = @"[-\\[\\]~`!@#$%^&*()_+=|}{:;'/?,.\"\\\\]*";
NSString *const yh_twoFourChinese = @"^[\\u4e00-\\u9fa5]{2,4}$";
NSString *const yh_formatDate = @"^((((1[6-9]|[2-9]\\d)\\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\\d|3[01]))|(((1[6-9]|[2-9]\\d)\\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\\d|30))|(((1[6-9]|[2-9]\\d)\\d{2})-0?2-(0?[1-9]|1\\d|2[0-8]))|(((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$";
NSString *const yh_twoSpitNumber = @"(^[1-9][0-9]{0,9}(\\.[0-9]{0,2})?)|(^0(\\.[0-9]{0,2})?)";
NSString *const yh_oneSixNumber = @"^\\d{1,6}$";
NSString *const yh_sixOnlyNumber = @"^\\d{6}$";
NSString *const yh_sixMoreNumber = @"^\\d{6,}$";









