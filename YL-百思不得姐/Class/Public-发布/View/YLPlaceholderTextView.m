//
//  YLPlaceholderTextView.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/10.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLPlaceholderTextView.h"

@implementation YLPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置默认字体
        self.font = [UIFont systemFontOfSize:17];
        //默认颜色
        self.placeholderColor = [UIColor lightGrayColor];
        //使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
//监听通知
- (void)textDidChange:(NSNotification *)note
{
    // 会重新调用drawRect:方法
    [self setNeedsDisplay];
}
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 * 每次调用drawRect:方法，都会将以前画的东西清除掉
 */
- (void)drawRect:(CGRect)rect {
    //有输入的字了，就返回
    //    if (self.text.length || self.attributedText.length) return;
    if (self.hasText) return;

    //文字的属性
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = self.font;
    attributes[NSForegroundColorAttributeName] = self.placeholderColor;
    //画文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attributes];
}

- (void)layoutSubviews
{
    [self layoutIfNeeded];
    [self setNeedsDisplay];

}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];

}
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
@end
