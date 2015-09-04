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

@end

@implementation YLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
