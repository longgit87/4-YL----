//
//  YLFriendTrendsViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLFriendTrendsViewController.h"
#import "YLLoginRegisterViewController.h"
#import "YLRecommendFollowViewController.h"

@interface YLFriendTrendsViewController ()

@end

@implementation YLFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    self.view.backgroundColor = YLCommonBgColor;
    
    //设置导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendClick)];
    

}
/**
 *  点击登录
 */
- (IBAction)login:(id)sender {
    
    YLLoginRegisterViewController *login = [[YLLoginRegisterViewController alloc]init];
    //跳转下一个控制器为从下往上钻
   [self.navigationController presentViewController:login animated:YES completion:nil];
 
}
- (void)friendClick
{

    YLRecommendFollowViewController *tvc = [[YLRecommendFollowViewController alloc]init];
    
    [self.navigationController pushViewController:tvc animated:YES];

}

@end
