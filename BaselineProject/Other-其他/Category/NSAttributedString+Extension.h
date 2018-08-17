//
//  NSAttributedString+Extension.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (Extension)

/**
 文字添加属性
 
 @param text 文字
 @param color 文字颜色
 @param font 文字大小
 */
+ (NSAttributedString *)attributedWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font;

/**
 弹框文本
 
 @param message 升级内容文本
 @return 新文本
 */
+ (NSAttributedString *)alertControllerWithMessage:(NSString *)message;

/**
 文本删除线
 
 @param text 文本
 @return 新文本
 */
+ (NSAttributedString *)textStrikethrough:(NSString *)text;

/**
 文本下划线
 
 @param text 文本
 */
+ (NSAttributedString *)textUnderline:(NSString *)text;

@end
