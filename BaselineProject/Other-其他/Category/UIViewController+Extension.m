//
//  UIViewController+Extension.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

+ (UIViewController *)topVC
{
    return UIApplication.sharedApplication.keyWindow.rootViewController.frontViewController;
}

- (UIViewController *)frontViewController
{
    if ([self isKindOfClass:[UINavigationController class]])
    {
        return [((UINavigationController *)self).topViewController frontViewController];
    }
    else if ([self isKindOfClass:[UITabBarController class]])
    {
        return [((UITabBarController *)self).selectedViewController frontViewController];
    }
    else if (self.navigationController && self != self.navigationController.visibleViewController)
    {
        return [self.navigationController.visibleViewController frontViewController];
    }
    else if (self.presentedViewController)
    {
        return [self.presentedViewController frontViewController];
    }
    else
    {
        return self;
    }
}

@end
