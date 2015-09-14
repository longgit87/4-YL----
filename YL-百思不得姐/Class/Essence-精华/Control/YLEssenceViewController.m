//
//  YLEssenceViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLEssenceViewController.h"
#import "YLTagViewControl.h"
#import "YLTitleButton.h"
#import "YLAllViewController.h"
#import "YLVideoViewController.h"
#import "YLVoiceViewController.h"
#import "YLPictureViewController.h"
#import "YLWordViewController.h"

@interface YLEssenceViewController ()
/**选中的按钮*/
@property (weak, nonatomic) YLTitleButton *selectedTitleBtn;
/**标题底部View*/
@property (weak, nonatomic) UIView *titleBottomView;
/**储存标题的按钮*/
@property (strong, nonatomic) NSMutableArray *titleButtons;
/** 这个scrollView的作用：存放所有子控制器的view */
@property (weak, nonatomic) UIScrollView *scrollView;
@end

@implementation YLEssenceViewController
- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
  return   _titleButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNavigationItem];
    
    [self setupChildVcs];
    
    [self setupScrollView];
    
    [self setupTitleView];
    

}
/**
 *  添加子控制器
 */
- (void)setupChildVcs
{

    //全部
    YLAllViewController *all = [[YLAllViewController alloc]init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    //视频
    YLVideoViewController *video = [[YLVideoViewController alloc]init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    //声音
    YLVoiceViewController *voice = [[YLVoiceViewController alloc]init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    //图片
    YLPictureViewController *picture = [[YLPictureViewController alloc]init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    //段子
    YLWordViewController *word = [[YLWordViewController alloc]init];
    word.title = @"段子";
    [self addChildViewController:word];


}
/**
 *  设置标题工具条
 */
- (void)setupTitleView
{

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
    
    
    //创建工具条标题按钮
    for (int i = 0; i < count; i++) {
        
        YLTitleButton *titleBtn = [[YLTitleButton alloc]init];
        [titleBtn setTitle:titileArr[i] forState:UIControlStateNormal];
        
        //计算按钮位置
        titleBtn.x = i * self.view.width / count;
        titleBtn.y = 0;
        titleBtn.width = width;
        titleBtn.height = titleView.height;
        
        //添加标题按钮的点击
        [titleBtn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleBtn];
        [self.titleButtons addObject:titleBtn];
        
    }
    //添加底部红色指示器
    UIView *titleBottomView = [[UIView alloc]init];
    titleBottomView.backgroundColor = [UIColor redColor];
    titleBottomView.height = 1;
 
    titleBottomView.y = titleView.height - titleBottomView.height;
   
    [titleView addSubview:titleBottomView];

    self.titleBottomView = titleBottomView;

    //默认点击最前面一个按钮
    YLTitleButton *firstButton = self.titleButtons.firstObject;
    [firstButton.titleLabel sizeToFit];
    titleBottomView.width = firstButton.titleLabel.width;
    titleBottomView.centerX = firstButton.centerX;
    [self clickTitleBtn:firstButton];

}
/**
 *  设置scrollView
 */
- (void)setupScrollView
{
    //创建一个scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
//    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(self.titleButtons.count * self.view.width, self.view.height);
    [self.view addSubview:scrollView];
    
    self.scrollView = scrollView;
YLLog(@"%@",NSStringFromUIEdgeInsets(self.scrollView.contentInset));

}
- (void)viewDidAppear:(BOOL)animated
{

    YLLog(@"%@",NSStringFromUIEdgeInsets(self.scrollView.contentInset));
}
/**
 *  点击标题按钮
 */
- (void)clickTitleBtn:(YLTitleButton *)titleButton
{
    titleButton.selected = YES;
    self.selectedTitleBtn.selected = NO;
    self.selectedTitleBtn = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.titleBottomView.width = titleButton.titleLabel.width;
        self.titleBottomView.centerX = titleButton.centerX;
    }];
    
    NSInteger index = [self.titleButtons indexOfObject:titleButton];

    self.scrollView.contentOffset = CGPointMake(index * self.view.width, 0);
    [self.scrollView setContentOffset:self.scrollView.contentOffset animated:YES];
   

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
/**
 *  点击了左上角标签
 */
- (void)tagClick
{
    YLTagViewControl *tag = [[YLTagViewControl alloc]init];
   
    tag.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tag animated:YES];

}

@end
