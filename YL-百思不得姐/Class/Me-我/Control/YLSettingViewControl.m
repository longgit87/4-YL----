//
//  YLSettingViewControl.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLSettingViewControl.h"
#import "NSString+YLEXT.h"
#import "YLClearCacheCell.h"
#import "YLThirdCell.h"

@implementation YLSettingViewControl

static NSString *const ClearCacheCell = @"YLClearCacheCell";
static NSString *const ThirdCell = @"YLThirdCell";
static NSString *const OtherCell = @"otherCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = YLCommonBgColor;

    
    [self.tableView registerClass:[YLClearCacheCell class] forCellReuseIdentifier:ClearCacheCell];
    
    [self.tableView registerClass:[YLThirdCell class] forCellReuseIdentifier:ThirdCell];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OtherCell];
    

    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = YLCommonMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(YLCommonMargin - 35, 0, -20, 0);
    
    

}
#pragma  mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:OtherCell];
    otherCell.textLabel.text = [NSString stringWithFormat:@"%zd----%zd",indexPath.section,indexPath.row];
    
    if (indexPath.section == 0 & indexPath.row == 0) {
        YLClearCacheCell *ClearCell = [tableView dequeueReusableCellWithIdentifier:ClearCacheCell];
        
        return ClearCell;
    }else if (indexPath.section == 1 & indexPath.row == 3){
        
        YLThirdCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:ThirdCell];
    
        return thirdCell;
    }
   

    return otherCell;

}
#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0 && indexPath.row == 0) {
        
        
        //取消选中
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        //清除缓存
        YLClearCacheCell *cell = (YLClearCacheCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        [cell clearCache];
        
    }

}
@end
