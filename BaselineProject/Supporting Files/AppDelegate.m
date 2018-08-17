//
//  AppDelegate.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "AppDelegate.h"

#import "UIWindow+Extension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 初始化SDK
    [UIWindow initSDK];
    // 1、创建窗口
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    // 3、显示窗口
    [self.window makeKeyAndVisible];
    // 2、设置根控制器
    [UIWindow switchRootViewController];
    
    return YES;
}

// 此方法在某一时刻才生效（4.2 < iOS Version < 9.0）
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

// 此方法在某一时刻才生效（iOS Version > 9.0）
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return YES;
}

//app 将要失去焦点
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

//app 已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

// app 将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

//app 已经获得焦点
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

//app 将要终止
- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
