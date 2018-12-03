//
//  UIImage+Extension.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

/**
 *  加载原始图片，没有系统渲染
 *
 *  @param imageName 图片名称
 *
 *  @return 返回原始图片对象
 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  图片拉伸
 *
 *  @param imageName 图片名
 */
+ (UIImage *)resizingImageWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.7, image.size.width * 0.5, image.size.height * 0.3 - 1,  image.size.width * 0.5 - 1)];
    
    return image;
}

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

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
{
    
    CGSize imageSize = CGSizeMake(image.size.width + 2 * borderW, image.size.height + 2 * borderW);
    
    // 1、开启上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, YES);
    
    // 2、绘制一个大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    
    [color set];
    // 3、填充
    [path fill];
    
    // 4、设置裁剪路径
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    
    // 5、裁剪
    [path addClip];
    
    // 6、把圆绘制到上下文中
    [image drawInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    
    // 7、获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8、关闭上下文
    UIGraphicsEndImageContext();
    
    // 9、返回新的图片
    return newImage;
    
}

/**
 *  返回一个圆角图片
 *
 *  @return 圆角图片
 */
- (instancetype)roundImage
{
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    // 添加路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    // 剪裁路径
    [path addClip];
    
    // 绘图
    [self drawAtPoint:CGPointZero];
    
    // 新图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭位图上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  根据cornerRadius返回圆角图片
 *
 *  @return 圆角图片
 */
- (instancetype)roundImageWithCornerRadius:(CGFloat)cornerRadius
{
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    // 添加路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:cornerRadius];
    
    // 剪裁路径
    [path addClip];
    
    // 绘图
    [self drawAtPoint:CGPointZero];
    
    // 新图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭位图上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 按照源图片的宽、高比例压缩至指定大小
 
 @param size 压缩大小
 */
- (UIImage *)scaleImageToSize:(CGSize)size
{
    if (!self) return nil;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    CGFloat widthFactor = size.width / width;
    CGFloat heightFactor = size.height / height;
    CGFloat scaleFactor = widthFactor < heightFactor ? widthFactor : heightFactor;
    
    width = width * scaleFactor * scale;
    height = height * scaleFactor * scale;
    
    UIGraphicsBeginImageContext(CGSizeMake(width,height));
    [self drawInRect:CGRectMake(0,0,width,height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 绘制虚线 图片
 
 @param size 图片大小
 @return 虚线图片
 */
+ (UIImage *)drawLineBySize:(CGSize)size
{
    // 开始画线 划线的frame
    UIGraphicsBeginImageContext(size);
    // 设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度 1是高度
    CGFloat lengths[] = {10,1};
    
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithWhite:0.408 alpha:1.000].CGColor);
    // 画虚线
    CGContextSetLineDash(line, 0, lengths, 2);
    // 开始画线
    CGContextMoveToPoint(line, 0.0, 0.0);
    CGContextAddLineToPoint(line, size.width, 0.0);
    
    CGContextStrokePath(line);
    // 返回image
    return UIGraphicsGetImageFromCurrentImageContext();
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

/**
 把 view 绘制成 image
 
 @param view 需要绘制的view
 */
+ (UIImage *)makeImageWithView:(UIView *)view
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
