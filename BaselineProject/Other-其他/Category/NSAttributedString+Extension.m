//
//  NSAttributedString+Extension.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

/**
 文字添加属性
 
 @param text 文字
 @param color 文字颜色
 @param font 文字大小
 */
+ (NSAttributedString *)attributedWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font
{
    if (text.length == 0) return nil;
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font,
                                 NSForegroundColorAttributeName : color,
                                 NSParagraphStyleAttributeName : paragraphStyle
                                 };
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

/**
 文字添加行间距
 
 @param text 文字
 */
+ (NSAttributedString *)addLineSpaceWithText:(NSString *)text
{
    if (text.length == 0) return nil;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    //行间距
    paragraphStyle.lineSpacing = 5.0;
    NSDictionary * attributes = @{
                                  NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                                  NSParagraphStyleAttributeName : paragraphStyle
                                  };
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

/**
 文本添加红色的“＊”号标记, 先设置文本颜色

 @param text 文本
 */
+ (NSAttributedString *)addRedStarWithText:(NSString *)text
{
    if (text.length == 0) return nil;
    
    // 创建富文本
    NSMutableAttributedString *attrubutedStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 创建红色的“＊”
    NSAttributedString *redStarStr = [[NSAttributedString alloc] initWithString:@"*" attributes:@{NSForegroundColorAttributeName : UIColor.redColor}];
    // 字符串拼接
    [attrubutedStr appendAttributedString:redStarStr];
    
    return attrubutedStr;
}

/**
 文字删除线
 
 @param text 文字
 */
+ (NSAttributedString *)textStrikethrough:(NSString *)text
{
    if (text.length == 0) return nil;
    
    // 中间划线
    NSDictionary *attribtDic = @{
                                 NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)
                                 };
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attribtDic];
}

/**
 文字下划线
 
 @param text 文字
 */
+ (NSAttributedString *)textUnderline:(NSString *)text
{
    if (text.length == 0) return nil;
    
    // 下划线
    NSDictionary *attribtDic = @{
                                 NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)
                                 };
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attribtDic];
}

@end
