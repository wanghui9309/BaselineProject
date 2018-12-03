//
//  TabBarController.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "HomeViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 取消tabBar的透明效果
//    self.tabBar.translucent = NO;
    // 添加所有的子控制器
    [self addChildViewControllers];
}

#pragma mark - 添加所有的子控制器
- (void)addChildViewControllers
{
    // 首页
    HomeViewController *home = [HomeViewController new];
    [self addOneChildViewController:home title:@"首页" imageName:@"" selectedImageName:@""];
}

#pragma mark - 添加单个子控制器
- (void)addOneChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.title = title;
    // 设置文字正常状态属性
    NSDictionary *textAttrNormal = @{NSForegroundColorAttributeName : [UIColor blueColor]};
    [vc.tabBarItem setTitleTextAttributes:textAttrNormal forState:UIControlStateNormal];
    
    // 设置文字选中状态下属性
    NSDictionary *textAttrSelected = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [vc.tabBarItem setTitleTextAttributes:textAttrSelected forState:UIControlStateSelected];
    
    //view 不向四周延展，原点从（导航栏）左下角开始算
//    vc.edgesForExtendedLayout = UIRectEdgeNone;
    
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (void)dealloc
{
    WHLog(@"%s dealloced", __func__);
}

@end
