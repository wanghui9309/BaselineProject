//
//  WHCustomTextView.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "WHCustomTextView.h"

@interface WHCustomTextView ()<UITextViewDelegate>

/** 输入视图 */
@property (nonatomic, weak) UITextView *textView;
/** 占位Label */
@property (nonatomic, weak) UILabel *placeholderLabel;
/** 剩余可输入字数 */
@property (nonatomic, weak) UILabel *surplusLabel;

@end

@implementation WHCustomTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self initUI];
    }
    return self;
}

/**
 初始化界面
 */
- (void)initUI
{
    // 背景颜色
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // 初始化font
    self.font = [UIFont systemFontOfSize:14.0f];
    // 输入视图
    [self textView];
    // 占位Label
    [self placeholderLabel];
    // 剩余可输入字数
    [self surplusLabel];
}

/**
 输入视图
 */
- (UITextView *)textView
{
    if (_textView == nil)
    {
        UITextView *textView = [[UITextView alloc] init];
        textView.translatesAutoresizingMaskIntoConstraints = NO;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor darkGrayColor];
        textView.font = self.font;
        textView.delegate = self;
        [self addSubview:textView];
        
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        top.active = YES;
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:textView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:5];
        leading.active = YES;
        NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:textView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
        trailing.active = YES;
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:textView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.surplusLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        bottom.active = YES;
        
        _textView = textView;
    }
    return _textView;
}

/**
 占位Label
 */
- (UILabel *)placeholderLabel
{
    if (_placeholderLabel == nil)
    {
        UILabel *lab = [[UILabel alloc]init];
        lab.translatesAutoresizingMaskIntoConstraints = NO;
        lab.backgroundColor = [UIColor clearColor];
        lab.numberOfLines = 0;
        lab.textColor = [UIColor lightGrayColor];
        lab.font = self.font;
        [self addSubview:lab];
        
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:lab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:7.0];
        top.active = YES;
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:lab attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10.0];
        leading.active = YES;
        NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:lab attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-10.0];
        trailing.active = YES;
        
        _placeholderLabel = lab;
    }
    return _placeholderLabel;
}

/**
 剩余可输入字数
 */
- (UILabel *)surplusLabel
{
    if (_surplusLabel == nil)
    {
        UILabel *lab = [[UILabel alloc] init];
        lab.translatesAutoresizingMaskIntoConstraints = NO;
        lab.textColor = [UIColor lightGrayColor];
        lab.font = self.font;
        lab.text = @"0/100";
        [self addSubview:lab];
        
        NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:lab attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-10.0];
        trailing.active = YES;
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:lab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.0];
        bottom.active = YES;
        
        _surplusLabel = lab;
        _maxLength = 100;
    }
    return _surplusLabel;
}

#pragma marl - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    _text = textView.text;
    self.placeholderLabel.hidden = textView.hasText;
    self.surplusLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)textView.text.length, (long)self.maxLength];
    
    if ([self.delegate respondsToSelector:@selector(textViewDidChange:)])
    {
        [self.delegate textViewDidChange:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return (textView.text.length + text.length) <= self.maxLength;
}

#pragma mark - Setter
- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    // 设置文字
    self.placeholderLabel.text = placeholderText;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    // 设置颜色
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setMaxLength:(NSInteger)maxLength
{
    _maxLength = maxLength;
    // 剩余可输入字数
    self.surplusLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)self.textView.text.length, (long)maxLength];
}

- (void)setText:(NSString *)text
{
    _text = text;
    // 文本赋值
    self.textView.text = text;
    
    [self textViewDidChange:self.textView];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    // 富文本赋值
    self.textView.attributedText = attributedText;
    
    [self textViewDidChange:self.textView];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    
    self.textView.font = font;
    self.placeholderLabel.font = font;
    self.surplusLabel.font = font;
}

- (void)setDelegate:(id<JYEBCustomTextViewDelegate>)delegate
{
    _delegate = delegate;
}

@end
