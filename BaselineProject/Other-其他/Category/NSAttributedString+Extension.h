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
 文字添加行间距
 
 @param text 文字
 */
+ (NSAttributedString *)addLineSpaceWithText:(NSString *)text;

/**
 文本添加红色的“＊”号标记, 先设置文本颜色
 
 @param text 文本
 */
+ (NSAttributedString *)addRedStarWithText:(NSString *)text;

/**
 文字删除线
 
 @param text 文字
 */
+ (NSAttributedString *)textStrikethrough:(NSString *)text;

/**
 文字下划线
 
 @param text 文字
 */
+ (NSAttributedString *)textUnderline:(NSString *)text;

@end
