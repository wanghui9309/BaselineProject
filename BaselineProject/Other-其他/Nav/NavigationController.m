//
//  NavigationController.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "NavigationController.h"

#import "UIBarButtonItem+Extension.h"

@interface NavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationController

+ (void)load
{
    UINavigationBar *navBar = nil;
    if (@available(iOS 9.0, *))
    {
        navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    }
    else
    {
        navBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    }
    
    /*
     navBar.barTintColor = WHColor(42, 183, 103);
     navBar.translucent = NO;
     */
    // 当设置不透明的图片，效果是如上面的代码，会导致View位移，在控制器里面使用 extendedLayoutIncludesOpaqueBars = YES就行了
    [navBar setBackgroundImage:[UIImage imageWithColor:UIColor.grayColor] forBarMetrics:UIBarMetricsDefault];
    
    //移除NavBar黑线
    navBar.shadowImage = [[UIImage alloc] init];
    NSDictionary *textAttr = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBar setTitleTextAttributes:textAttr];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 默认启用滑动手势
    self.panEnabled = YES;
    
    // 1、取消系统手势返回功能
    self.interactivePopGestureRecognizer.enabled = NO;
    
    /*
     <UIScreenEdgePanGestureRecognizer: 0x135e89c80; state = Possible; enabled = NO; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x135dc6100>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x135e89790>)>>
     
     */
    
    // 2、添加全屏返回手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //view 不向四周延展，原点从（导航栏）左下角开始算
//    viewController.edgesForExtendedLayout = UIRectEdgeNone;
    //当NavBar使用了不透明图片时，视图是否延伸至NavBar所在区域，默认值时NO
//    viewController.extendedLayoutIncludesOpaqueBars = YES;
    
    // 非根控制器显示Nav
    if (self.childViewControllers.count >= 1)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"nav_back_normal"] highImage:nil target:self action: @selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 点击事件
- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.panEnabled;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{}

@end
