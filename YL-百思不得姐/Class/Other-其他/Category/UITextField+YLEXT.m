
//
//  UITextField+YLEXT.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/11.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "UITextField+YLEXT.h"

@implementation UITextField (YLEXT)

static NSString *const YLPlaceholderColorKey = @"placeholderLabel.textColor";

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    BOOL change = NO;
      // 保证有占位文字
    if (self.placeholder == nil) {
        
        self.placeholder = @" ";
        change = YES;
    }
    // 设置占位文字颜色
   [self setValue:placeholderColor forKeyPath:YLPlaceholderColorKey];

     // 恢复原状
    if (change) {
        
        self.placeholder = nil;
    }

}

- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:YLPlaceholderColorKey];
}
@end
