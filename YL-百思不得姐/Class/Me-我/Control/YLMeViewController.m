//
//  YLMeViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLMeViewController.h"
#import "YLSettingViewControl.h"

@interface YLMeViewController ()

@end

@implementation YLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = YLCommonBgColor;
    
    UIBarButtonItem *itemSetting = [UIBarButtonItem itemWithimage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *itemMoon = [UIBarButtonItem itemWithimage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[itemSetting,itemMoon];
    
   
}

- (void)settingClick
{
    YLSettingViewControl *settingVc = [[YLSettingViewControl alloc]init];
    settingVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVc animated:YES];
    
}

- (void)moonClick
{
    YLLogFunc;


}
@end
