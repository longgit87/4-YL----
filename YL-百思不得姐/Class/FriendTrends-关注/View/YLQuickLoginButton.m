//
//  YLQuickLoginButton.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/3.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLQuickLoginButton.h"


@implementation YLQuickLoginButton


- (void)awakeFromNib
{
    //设置label文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


- (void)layoutSubviews
{

    [super layoutSubviews];
    
    //图片位置
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    //文字位置
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width ;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}


@end
