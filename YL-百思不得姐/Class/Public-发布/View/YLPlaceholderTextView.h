//
//  YLPlaceholderTextView.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/10.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLPlaceholderTextView : UITextView
/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
