//
//  NSString+Extension.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 将汉字转成拼音, 过滤空字符、&
 
 @param chinese 要转换的汉字
 @return 返回转换的拼音
 */
+ (NSString *)transform:(NSString *)chinese;

/**
 获取 13位时间戳
 
 @return TimeInterval 毫秒
 */
+ (NSString *)createTm;

/**
 时间戳转换
 
 @param string 时间戳
 @return 格式化的时间 yyyy-MM-dd HH:mm, 昨天HH:mm, 前天HH:mm
 */
+ (NSString *)interceptTimeStampFromStr:(NSString *)string;

/**
 获取字符串中数字
 
 @return 数字字符串
 */
- (NSString *)getNumberStr;

/**
 验证码手机号
 
 @param mobileNum 手机号
 @return YES 通过 NO 不通过
 */
+ (BOOL)validateContactNumber:(NSString *)mobileNum;

@end
