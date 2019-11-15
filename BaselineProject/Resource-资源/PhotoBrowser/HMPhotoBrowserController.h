//
//  HMPhotoBrowserController.h
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 照片浏览控制器
@interface HMPhotoBrowserController : UIViewController

/// 实例化照片浏览器
///
/// @param selectedIndex    选中照片索引
/// @param urls             浏览照片 URL 字符串数组
///
/// @return 照片浏览器
+ (nonnull instancetype)photoBrowserWithSelectedIndex:(NSInteger)selectedIndex
                                                 urls:(NSArray <NSString *> * _Nonnull)urls;

@end
