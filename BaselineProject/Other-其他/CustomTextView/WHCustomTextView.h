//
//  WHCustomTextView.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface WHCustomTextView : UITextView

/** 文字 */
@property(nonatomic, strong) IBInspectable NSString *placeholderText;
/** 文字颜色 */
@property(nonatomic, strong) IBInspectable UIColor *placeholderColor;

@end
