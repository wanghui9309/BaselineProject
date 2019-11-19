//
//  WHWebViewController.h
//
//  Created by WangHui on 2016/12/17.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHWebViewController : UIViewController

/**
 快速创建控制器
 
 @param title 标题
 @param url 网页URL
 @return WHWebViewController
 */
+ (instancetype)WebViewControllerWithTitile:(NSString *)title withWebUrl:(NSString *)url;

@end
