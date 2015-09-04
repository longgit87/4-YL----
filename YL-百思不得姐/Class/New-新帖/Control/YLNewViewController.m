//
//  YLNewViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLNewViewController.h"

@interface YLNewViewController ()

@end

@implementation YLNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.view.backgroundColor = YLCommonBgColor;


    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
}
- (void)tagClick
{
    YLLogFunc;
}
@end
