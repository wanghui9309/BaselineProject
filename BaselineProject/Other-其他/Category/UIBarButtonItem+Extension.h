//
//  UIBarButtonItem+Extension.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 UIBarButtonItem 创建
 
 @param image 默认图片
 @param highImage 高亮图片
 @param target 接收者
 @param action 执行方法
 */
+ (UIBarButtonItem *)barItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

/**
 UIBarButtonItem 创建
 
 @param image 默认图片
 @param selectImage 选中图片
 @param target 接收者
 @param action 执行方法
 */
+ (UIBarButtonItem *)barItemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(id)target action:(SEL)action;

/**
 UIBarButtonItem 创建
 
 @param title 标题
 @param target 接收者
 @param action 执行方法
 */
+ (UIBarButtonItem *)barItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 UIBarButtonItem 创建
 
 @param image 背景图片
 @param target 接收者
 @param action 执行方法
 */
+ (UIBarButtonItem *)barItemWithBackgroundImage:(UIImage *)image target:(id)target action:(SEL)action;

/**
 UIBarButtonItem 创建
 
 @param title title
 @param titleColor titleColor
 @param fontSize fontSize
 @param target 调用者
 @param action 调用者的方法
 */
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize addTarget:(id)target action:(SEL)action;

@end
