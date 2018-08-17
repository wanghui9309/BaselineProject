//
//  UIWindow+Extension.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "UIWindow+Extension.h"

#import "TabBarController.h"

#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation UIWindow (Extension)

/**
 切换到根控制器
 */
+ (void)switchRootViewController
{
    // 获取keyWindow
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    window.rootViewController = [TabBarController new];
}

/**
 初始化 SDK
 */
+ (void)initSDK
{
    // 控制键盘功能启用
    [IQKeyboardManager sharedManager].enable = YES;
    // 控制点击背景收起键盘。
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    // 控制不显示键盘上的工具条
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    // 添加DDTTYLogger，你的日志语句将被发送到Xcode控制台
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}

@end
