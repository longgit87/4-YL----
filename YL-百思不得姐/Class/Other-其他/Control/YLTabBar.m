//
//  YLTabBar.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTabBar.h"
#import "YLPublicViewController.h"
#import "YLAddTagViewController.h"

@interface YLTabBar ()

@property (weak, nonatomic) UIButton *publishBtn;

@end

@implementation YLTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
        //添加发布按钮
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishBtn];
        [publishBtn sizeToFit];
        [publishBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.publishBtn = publishBtn;
    }

    return self;
}
- (void)publishClick
{
//    YLPublicViewController *public = [[YLPublicViewController alloc]init];
//    [self.window.rootViewController presentViewController:public animated:NO completion:nil];
    YLAddTagViewController *tag = [[YLAddTagViewController alloc]init];
    YLNavigationControl *nav = [[YLNavigationControl alloc]initWithRootViewController:tag];
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}
/**
 *  布局按钮位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    //tabbar的尺寸
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    //设置发布按钮的位置
    self.publishBtn.center = CGPointMake(width * 0.5, height * 0.5);
    
    int index = 0;
    //按钮的尺寸
    CGFloat w = width / 5;
    CGFloat h = height;

    CGFloat y = 0;
    //设置4个按钮的frame
    for (UIView *view in self.subviews) {
        
        if (![NSStringFromClass(view.class) isEqualToString:@"UITabBarButton"])  continue;

        //计算x值
        CGFloat x = index * w;
        if (index >= 2) {
        
            x += w;
            
        }
        
        view.frame = CGRectMake(x, y, w, h);
  
       //增加索引
        index++;
    }
    
}

@end
