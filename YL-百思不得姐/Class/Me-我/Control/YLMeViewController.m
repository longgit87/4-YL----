//
//  YLMeViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLMeViewController.h"
#import "YLSettingViewControl.h"
#import "YLMeCell.h"
#import "YLFooterView.h"

@interface YLMeViewController ()

@end

@implementation YLMeViewController

static NSString *MeId = @"Me";

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNav];
    
    //设置tableview
    [self setupTableView];
    

}
//设置tableview相关
- (void)setupTableView
{
    //注册标识符
    [self.tableView registerClass:[YLMeCell class]forCellReuseIdentifier:MeId];
    
    self.tableView.backgroundColor = YLCommonBgColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = YLCommonMargin;
    // 设置内边距(-25代表：所有内容往上移动25)
    self.tableView.contentInset = UIEdgeInsetsMake(YLCommonMargin - 35, 0, 0, 0);
    //添加footerview
    self.tableView.tableFooterView = [[YLFooterView alloc]init];
  

    
}
//设置导航栏相关
- (void)setupNav
{
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = YLCommonBgColor;
    
    UIBarButtonItem *itemSetting = [UIBarButtonItem itemWithimage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *itemMoon = [UIBarButtonItem itemWithimage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[itemSetting,itemMoon];
    
}
//点击了设置
- (void)settingClick
{
    YLSettingViewControl *settingVc = [[YLSettingViewControl alloc]init];
    settingVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVc animated:YES];
    
}
//点击了夜晚
- (void)moonClick
{
    YLLogFunc;
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YLMeCell *cell = [tableView dequeueReusableCellWithIdentifier:MeId];
    
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else
    {
       cell.textLabel.text = @"离线下载";
    
    }
       return cell;
}

@end
