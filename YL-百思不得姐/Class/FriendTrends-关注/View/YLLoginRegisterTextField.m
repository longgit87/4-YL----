//
//  YLLoginRegisterTextField.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/3.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLLoginRegisterTextField.h"

@implementation YLLoginRegisterTextField

- (void)awakeFromNib
{

    //设置光标颜色
    self.tintColor = [UIColor whiteColor];

    //设置文本框文字颜色
    self.textColor = [UIColor whiteColor];
    
    
//    [self addTarget:self action:@selector(beginEdit) forControlEvents:UIControlEventEditingDidBegin];
//    [self addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventEditingDidEnd];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEdit) name:UITextFieldTextDidBeginEditingNotification object:self];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEdit) name:UITextFieldTextDidEndEditingNotification object:self];
}
//- (void)dealloc
//{
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//
//}

- (BOOL)becomeFirstResponder
{

    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
    
    return [super becomeFirstResponder];
}
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    
    return [super resignFirstResponder];
}
//- (void)beginEdit
//{
//    
//    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
//
//}
//- (void)endEdit
//{
//    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
//}

@end
