//
//  UIImage+Extension.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  加载原始图片，没有系统渲染
 *
 *  @param imageName 图片名称
 *
 *  @return 返回原始图片对象
 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

/**
 *  图片拉伸
 *
 *  @param imageName 图片名
 */
+ (UIImage *)resizingImageWithImageName:(NSString *)imageName;

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  生成带边框的圆形图片
 *
 *  @param borderW 边框宽度
 *  @param color   边框颜色
 *  @param image   图片
 *
 *  @return 新的图片对象
 */
+ (UIImage *)imageWithBorderW:(CGFloat)borderW color:(UIColor *)color image:(UIImage *)image;

/**
 *  返回一个圆角图片
 *
 *  @return 圆角图片
 */
- (instancetype)roundImage;

/**
 *  根据cornerRadius返回圆角图片
 *
 *  @return 圆角图片
 */
- (instancetype)roundImageWithCornerRadius:(CGFloat)cornerRadius;

/**
 按照源图片的宽、高比例压缩至指定大小
 
 @param size 压缩大小
 */
- (UIImage *)scaleImageToSize:(CGSize)size;

/**
 绘制虚线 图片
 
 @param size 图片大小
 */
+ (UIImage *)drawLineBySize:(CGSize)size;

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

/**
 把 view 绘制成 image
 
 @param view 需要绘制的view
 */
+ (UIImage *)makeImageWithView:(UIView *)view;

@end
