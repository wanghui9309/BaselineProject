//
//  UIColor+Extension.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 颜色字符串转color, 默认alpha值为1
 
 @param stringToConvert 要转换的字符串
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/**
 从十六进制字符串获取颜色

 @param color 支持@"#123456"、 @"0X123456"、 @"123456"三种格式
 @param alpha alpha
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
