//
//  UIImageView+Extension.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

/**
 按照源图片的宽、高比例压缩至目标宽、高
 
 @param image 源图
 */
- (void)scaleToSize:(UIImage *)image
{
    CGSize newSize = self.bounds.size;
    if (image)
    {
        if ([NSStringFromCGSize(self.image.size) isEqualToString:NSStringFromCGSize(image.size)])
        {
            self.image = image;
            return;
        }
        
        CGFloat scale = [UIScreen mainScreen].scale;
        CGFloat width = image.size.width;
        CGFloat height = image.size.height;
        
        CGFloat widthFactor = newSize.width / width;
        CGFloat heightFactor = newSize.height / height;
        CGFloat scaleFactor = widthFactor < heightFactor ? widthFactor : heightFactor;
        
        width = width * scaleFactor * scale;
        height = height * scaleFactor * scale;
        
        UIGraphicsBeginImageContext(CGSizeMake(width,height));
        [image drawInRect:CGRectMake(0,0,width,height)];
        self.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

@end
