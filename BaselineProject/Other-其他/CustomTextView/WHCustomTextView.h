//
//  WHCustomTextView.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WHCustomTextView;

@protocol JYEBCustomTextViewDelegate <NSObject>

@optional
/**
 文字完成改变
 */
- (void)textViewDidChange:(WHCustomTextView *)textView;

@end

IB_DESIGNABLE
@interface WHCustomTextView : UIView

@property (nonatomic, weak) IBInspectable id<JYEBCustomTextViewDelegate> delegate;
/** 占位文字 */
@property (nonatomic, strong) IBInspectable NSString *placeholderText;
/** 占位文字颜色 */
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
/** 最大文字长度，默认：100 */
@property (nonatomic, assign) IBInspectable NSInteger maxLength;
/** 输入文本 */
@property (nonatomic, strong) IBInspectable NSString *text;
/** 富文本 */
@property (nonatomic, strong) IBInspectable NSAttributedString *attributedText;
/** 文字font, 默认：14 */
@property (nonatomic, strong) IBInspectable UIFont *font;

@end
