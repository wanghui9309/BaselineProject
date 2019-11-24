//
//  UIView+init.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (init)

/**
 *  快速创建的类方法
 *
 */
+ (instancetype)wt_viewFromXib;

/**
 实现一边圆角
 
 @param bounds 要实现圆角控制的Bounds
 @param corners 圆角的方向
 @param cornerRadii 圆角的大小
 @return CAShapeLayer
 */
+ (CAShapeLayer *)rectCornerWithRect:(CGRect)bounds byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 颜色垂直渐变，从这个颜色渐变另外一个颜色
 
 @param startColor 起始颜色
 @param endColor 结束颜色
 */
- (void)verticalGradientFromWithColor:(UIColor *)startColor toColor:(UIColor *)endColor;

/**
 *  生成带边框的视图
 *
 *  @param borderW 边框宽度
 *  @param color   边框颜色
 */
- (void)drawCircleWithBorderW:(CGFloat)borderW color:(UIColor *)color;

@end
