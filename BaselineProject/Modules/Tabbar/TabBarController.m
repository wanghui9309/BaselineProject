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

/// 中间按钮
@property (nonatomic, weak) UIButton *centerBtn;

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 取消tabBar的透明效果
//    self.tabBar.translucent = NO;
    // 添加所有的子控制器
    [self addChildViewControllers];
    // 添加中心按钮
//    [self addCenterButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.tabBar bringSubviewToFront:self.centerBtn];
}

#pragma mark - 添加中间按钮
- (void)addCenterButton
{
    CGFloat count = self.childViewControllers.count;
    /// 向内缩进的宽度
    CGFloat w = self.tabBar.width / count;
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectInset(self.tabBar.bounds, w, 0);
    [button setTitle:@"自定义按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:button];
    _centerBtn = button;
}

#pragma mark - 添加所有的子控制器
- (void)addChildViewControllers
{
    // 首页
    HomeViewController *home0 = [HomeViewController new];
    [self addOneChildViewController:home0 title:@"首页0" imageName:@"home_normal" selectedImageName:@"home_highlight"];
    
    HomeViewController *home1 = [HomeViewController new];
    [self addOneChildViewController:home1 title:@"首页1" imageName:@"home_normal" selectedImageName:@"home_highlight"];
    
    HomeViewController *home2 = [HomeViewController new];
    [self addOneChildViewController:home2 title:@"首页2" imageName:@"home_normal" selectedImageName:@"home_highlight"];
}

#pragma mark - 添加单个子控制器
- (void)addOneChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.title = title;
    // 设置文字正常状态属性
    NSDictionary *textAttrNormal = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [vc.tabBarItem setTitleTextAttributes:textAttrNormal forState:UIControlStateNormal];
    
    // 设置文字选中状态下属性
    NSDictionary *textAttrSelected = @{NSForegroundColorAttributeName : [UIColor blueColor]};
    [vc.tabBarItem setTitleTextAttributes:textAttrSelected forState:UIControlStateSelected];
    
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - 点击事件
/// 中间按钮点击
- (void)clickButtonAction
{
    [self setSelectedIndex:1];
}

- (void)dealloc
{
    WHLog(@"%s dealloced", __func__);
}

@end
