//
//  YLPictureViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/14.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLPictureViewController.h"

@interface YLPictureViewController ()

@end

@implementation YLPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = YLCommonBgColor;
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(YLNavBarMaxY + YLTitleHeight, 0, YLTabBarHeight, 0);
    //设置右边滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    
}

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
