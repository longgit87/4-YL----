//
//  YLEssenceViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLEssenceViewController.h"
#import "YLTagViewControl.h"

@interface YLEssenceViewController ()
@property (weak, nonatomic) UIButton *btn;

@end

@implementation YLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNavigationItem];
    
    
    //添加titleView
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    //设置标题View的frame
    titleView.x = 0;
    titleView.y = 64;
    titleView.width = self.view.width;
    titleView.height = 35;

    [self.view addSubview:titleView];

    //添加titleView里面的按钮
    NSArray *titileArr = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    NSInteger count = titileArr.count;
    CGFloat width = self.view.bounds.size.width / count;

    
    
    for (int i = 0; i < count; i++) {
        
        UIButton *titleBtn = [[UIButton alloc]init];
        [titleBtn setTitle:titileArr[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        //计算按钮位置
        titleBtn.x = i * self.view.width / count;
        titleBtn.y = 0;
        titleBtn.width = width;
        titleBtn.height = titleView.height;

        [titleBtn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchDown];
        [titleView addSubview:titleBtn];
        
    }
    //添加底部红色指示器
    
    
}
//点击标题按钮
- (void)clickTitleBtn:(UIButton *)btn
{
    btn.selected = YES;
    self.btn.selected = NO;
    self.btn = btn;
   

}
//设置导航栏
- (void)setUpNavigationItem
{
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置控制器背景颜色（通用颜色）
    self.view.backgroundColor = YLCommonBgColor;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

}

- (void)tagClick
{
    YLTagViewControl *tag = [[YLTagViewControl alloc]init];
   
    tag.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tag animated:YES];

}

@end
