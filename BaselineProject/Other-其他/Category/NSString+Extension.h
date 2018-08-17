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
 是否是手机号码
 
 @param mobileNumbel 手机号码
 @return yes:是，no:不是
 */
+ (BOOL)isMobile:(NSString *)mobileNumbel;

@end
