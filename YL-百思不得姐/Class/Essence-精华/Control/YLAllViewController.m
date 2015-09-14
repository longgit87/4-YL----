//
//  YLAllViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/14.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLAllViewController.h"

@interface YLAllViewController ()

@end

@implementation YLAllViewController
/*
 1.要想让一个scrollView的内容能够穿透整个屏幕
 1> 让scrollView的frame占据整个屏幕
 
 2.要想让用户能看清楚所有的内容，不被导航栏和tabbar挡住
 1> 设置scrollView的contentInset属性
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = YLCommonBgColor;
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(YLNavBarMaxY + YLTitleHeight, 0, YLTabBarHeight, 0);
    //设置右边滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@--%zd",self.title,indexPath.row];
    return cell;
}



@end
