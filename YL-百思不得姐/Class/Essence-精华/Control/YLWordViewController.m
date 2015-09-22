//
//  YLWordViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/14.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLWordViewController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "YLTopic.h"
#import "YLTopicCell.h"
#import "YLCommentViewController.h"

@interface YLWordViewController ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) NSMutableArray *topics;
@property (strong, nonatomic) NSString *maxtime;

@end

@implementation YLWordViewController
static NSString *const ID = @"cell";
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupRefresh];
    
}
- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.header.automaticallyChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    
}
- (void)loadNewTopics
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(YLTopicTypeWord);

    YLWeadSelf;
    [self.manager GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask *task , id responseObject) {
        weakSelf.topics = [YLTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.tableView reloadData];
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        [weakSelf.tableView.header endRefreshing];
        
    } failure:^ void(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf.tableView.header endRefreshing];
    }];

}
- (void)loadMoreTopics
{

    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(YLTopicTypeWord);
    parameters[@"maxtime"] = self.maxtime;
    YLWeadSelf;
    [self.manager GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *newTpoics = [YLTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.topics addObjectsFromArray:newTpoics];
        [weakSelf.tableView reloadData];
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        [weakSelf.tableView.footer endRefreshing];
        
    } failure:^ void(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf.tableView.footer endRefreshing];
        
    }];

}
- (void)setupTable
{

    self.tableView.backgroundColor = YLCommonBgColor;
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(YLNavBarMaxY + YLTitleHeight, 0, YLTabBarHeight, 0);
    //设置右边滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YLTopicCell class]) bundle:nil] forCellReuseIdentifier:ID];


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YLTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.topic = self.topics[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLCommentViewController *commentVc = [[YLCommentViewController alloc]init];
    commentVc.topic = self.topics[indexPath.row];
    
    
    [self.navigationController pushViewController:commentVc animated:YES];


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLTopic *topic = self.topics[indexPath.row];
   
    return topic.cellHeight;

}
@end
