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
 弹框文本
 
 @param message 升级内容文本
 @return 新文本
 */
+ (NSAttributedString *)alertControllerWithMessage:(NSString *)message
{
    if (message.length == 0)
    {
        return nil;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    //行间距
    paragraphStyle.lineSpacing = 5.0;
    NSDictionary * attributes = @{
                                  NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                                  NSParagraphStyleAttributeName : paragraphStyle
                                  };
    return [[NSMutableAttributedString alloc] initWithString:message attributes:attributes];
}

/**
 文本删除线
 
 @param text 文本
 @return 新文本
 */
+ (NSAttributedString *)textStrikethrough:(NSString *)text
{
    // 中间划线
    NSDictionary *attribtDic = @{
                                 NSStrikethroughStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                 };
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attribtDic];
}

/**
 文本下划线
 
 @param text 文本
 */
+ (NSAttributedString *)textUnderline:(NSString *)text
{
    // 下划线
    NSDictionary *attribtDic = @{
                                 NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)
                                 };
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attribtDic];
}

@end
