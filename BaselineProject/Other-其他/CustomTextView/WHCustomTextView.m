//
//  WHCustomTextView.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "WHCustomTextView.h"

@interface WHCustomTextView()

@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation WHCustomTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self initPlaceholderLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self initPlaceholderLabel];
    }
    return self;
}

/**
 初始化PlaceholderLabel
 */
- (void)initPlaceholderLabel
{
    if (_placeholderLabel == nil)
    {
        //添加一个占位label
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.backgroundColor = [UIColor clearColor];
        //设置可以输入多行文字时可以自动换行
        placeholderLabel.numberOfLines = 0;
        //设置占位文字默认颜色
        placeholderLabel.textColor = [UIColor lightGrayColor];
        //设置默认的字体
        placeholderLabel.font = self.font;
        [self addSubview:placeholderLabel];
        //赋值保存
        _placeholderLabel = placeholderLabel;
        //通知:监听文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置UILabel 的 y值
    self.placeholderLabel.y = 8;
    //设置 UILabel 的 x 值
    self.placeholderLabel.x = 5;
    //设置 UILabel 的 x
    self.placeholderLabel.w = self.w - self.placeholderLabel.x * 2.0;
    //根据文字计算高度
    CGSize maxSize = CGSizeMake(self.placeholderLabel.w, MAXFLOAT);
    self.placeholderLabel.h = [self.placeholderText boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
}

#pragma mark -监听文字改变
- (void)textDidChange
{
    self.placeholderLabel.hidden = self.hasText;
}

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    //设置文字
    self.placeholderLabel.text = placeholderText;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    //设置颜色
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setText:(NSString*)text
{
    [super setText:text];
    //这里调用的就是 UITextViewTextDidChangeNotification 通知的回调
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString*)attributedText
{
    [super setAttributedText:attributedText];
    //这里调用的就是UITextViewTextDidChangeNotification 通知的回调
    [self textDidChange];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
}

@end
