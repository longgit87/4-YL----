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
static NSString *ID = @"all";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[YLAllViewController class] forCellReuseIdentifier:ID];

}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@--%zd",self.title,indexPath.row];
    YLLog(@"%@",cell.textLabel.text);
    return cell;
}



@end
