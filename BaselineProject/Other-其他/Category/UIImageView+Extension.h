//
//  UIImageView+Extension.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

/**
 按照源图片的宽、高比例压缩至目标宽、高
 
 @param image 源图
 */
- (void)scaleToSize:(UIImage *)image;

@end
