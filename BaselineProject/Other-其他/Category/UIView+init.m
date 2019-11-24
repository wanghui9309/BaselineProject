//
//  UIView+init.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "UIView+init.h"

@implementation UIView (init)

/**
 *  快速创建的类方法
 *
 */
+ (instancetype)wt_viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

/**
 实现一边圆角
 
 @param bounds 要实现圆角控制的Bounds
 @param corners 圆角的方向
 @param cornerRadii 圆角的大小
 @return CAShapeLayer
 */
+ (CAShapeLayer *)rectCornerWithRect:(CGRect)bounds byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    return maskLayer;
}

/**
 颜色垂直渐变，从这个颜色渐变另外一个颜色
 
 @param startColor 起始颜色
 @param endColor 结束颜色
 */
- (void)verticalGradientFromWithColor:(UIColor *)startColor toColor:(UIColor *)endColor
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@(0.0),@(1.0)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(0, 1);
    [self.layer addSublayer:gradientLayer];
}

/**
 *  生成带边框的视图
 *
 *  @param borderW 边框宽度
 *  @param color   边框颜色
 */
- (void)drawCircleWithBorderW:(CGFloat)borderW color:(UIColor *)color
{
    CGSize size = CGSizeMake(self.size.width + 2 * borderW, self.size.height + 2 * borderW);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    maskLayer.lineWidth = borderW;
    maskLayer.strokeColor = color.CGColor;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:maskLayer];
}

@end
