//
//  NSString+Extension.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/**
 将汉字转成拼音, 过滤空字符、&
 
 @param chinese 要转换的汉字
 @return 返回转换的拼音
 */
+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    
    NSString *str = [[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"／" withString:@""];
    return str;
}

/**
 获取 13位时间戳
 
 @return TimeInterval 毫秒
 */
+ (NSString *)createTm
{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInter = [dat timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%.0f", timeInter];
}

/**
 时间戳转换
 
 @param string 时间戳
 @return 格式化的时间 yyyy-MM-dd HH:mm, 昨天HH:mm, 前天HH:mm
 */
+ (NSString *)interceptTimeStampFromStr:(NSString *)string
{
    if (!string || [string length] == 0 )
    {  // 字符串为空判断
        return @"";
    }
    // 时间转成 date
    NSTimeInterval interval = [string doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    //修正8小时的差时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger intervalGMT = [zone secondsFromGMTForDate:date];
    NSDate *endDate = [date dateByAddingTimeInterval:intervalGMT];
    return [NSString compareDate:endDate];
}

+ (NSString *)compareDate:(NSDate *)date
{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //修正8小时之差
    NSDate *nowDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:nowDate];
    NSDate *today = [nowDate dateByAddingTimeInterval:interval];
    
    // 昨天当前时间，包括 时 分 秒
    NSDate *yesterday = [today dateByAddingTimeInterval:-secondsPerDay];
    // 前天当前时间，包括 时 分 秒
    NSDate *beforeOfYesterday = [yesterday dateByAddingTimeInterval:-secondsPerDay];
    
    // 今天
    NSString *todayString = [[today description] substringToIndex:10];
    // 昨天
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    // 前天
    NSString *beforeOfYesterdayString = [[beforeOfYesterday description] substringToIndex:10];
    
    NSString *dateString = [[date description] substringToIndex:10];
    
    //今 昨 前天的时间
    NSString *time = [[date description] substringWithRange:(NSRange){11,5}];
    if ([dateString isEqualToString:todayString])
    {
        return [NSString stringWithFormat:@"%@",time];
    }
    else if ([dateString isEqualToString:yesterdayString])
    {
        return [NSString stringWithFormat:@"昨天%@",time];
    }
    else if ([dateString isEqualToString:beforeOfYesterdayString])
    {
        return [NSString stringWithFormat:@"前天%@",time];
    }
    else
    {
        return dateString;
    }
}

/**
 获取字符串中数字
 
 @return 数字字符串
 */
- (NSString *)getNumberStr
{
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSArray *strArr = [self componentsSeparatedByCharactersInSet:characterSet.invertedSet];
    return [strArr componentsJoinedByString:@""];
}

/**
 验证码手机号
 
 @param mobileNum 手机号
 @return YES 通过 NO 不通过
 */
+ (BOOL)validateContactNumber:(NSString *)mobileNum
{
    mobileNum = mobileNum.getNumberStr;
    
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 16[6], 17[5, 6, 7, 8], 18[0-9], 170[0-9], 19[89]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705,198
     * 联通号段: 130,131,132,155,156,185,186,145,175,176,1709,166
     * 电信号段: 133,153,180,181,189,177,1700,199
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[05-8]|8[0-9]|9[89])\\d{8}$";
    
    /**
     * 中国移动:China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705,198
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
    
    /**
     * 中国联通:China Unicom
     * 130,131,132,155,156,185,186,145,175,176,1709,166
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|66|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    
    /**
     * 中国电信:China Telecom
     * 133,153,180,181,189,177,1700,199
     */
    NSString *CT = @"(^1(33|53|77|8[019]|99)\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)
       || ([regextestPHS evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

@end
