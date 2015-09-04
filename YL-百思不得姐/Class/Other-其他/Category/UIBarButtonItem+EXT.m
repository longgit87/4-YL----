//
//  UIBarButtonItem+EXT.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "UIBarButtonItem+EXT.h"

@implementation UIBarButtonItem (EXT)

+ (instancetype)itemWithimage:(NSString *)image hightImage:(NSString *)hightImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item  = [[self alloc]initWithCustomView:btn];

    return item;

}


@end
