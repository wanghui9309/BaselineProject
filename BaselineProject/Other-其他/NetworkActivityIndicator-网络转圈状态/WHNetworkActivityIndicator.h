//
//  WHNetworkActivityIndicator.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHNetworkActivityIndicator : NSObject

+ (id)sharedActivityIndicator;
/**
 开始下载活动
 */
- (void)startActivity;
/**
 关闭下载活动
 */
- (void)stopActivity;
/**
 关闭全部下载活动
 */
- (void)stopAllActivity;


@end
