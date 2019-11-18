//
//  AppDelegate.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "AppDelegate.h"

#import "UIWindow+Extension.h"

#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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

// 此方法在某一时刻才生效（iOS Version > 9.0）
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return YES;
}

// app 将要失去焦点
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

// app 已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

// app 将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

// app 已经获得焦点
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

// app 将要终止
- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

#pragma mark - APNS
// 注册成功回调方法，其中deviceToken即为APNs返回的token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 发送deviceToken到你的服务器端
    NSLog(@"deviceToken:%@", deviceToken);
}

// 应用处于前台状态触发, 获取远程推送 兼容 iOS 7 以下推送环境
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

/**
 iOS 7 以后远程推送触发, 不管在前台还是后台, 远程推送系统默认按格式显示
 此方法需要配置后台模式并且在推送负载中必须有 "content-available" : 1 否则不会触发(默认：静默模式)
*/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0))
{
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0))
{
    completionHandler();
}


@end
