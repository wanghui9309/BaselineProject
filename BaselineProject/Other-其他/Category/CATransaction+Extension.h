//
//  CATransaction+Extension.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CATransaction (Extension)

/**
 present动画效果
 
 @param theView 添加动画的view
 */
+ (void)presentAnimationWithView:(UIView *)theView;

/**
 dismiss动画效果
 
 @param theView 添加动画的view
 */
+ (void)dismissAnimationWithView:(UIView *)theView;

@end
