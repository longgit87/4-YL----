//
//  YLTopicViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/22.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTopicViewController.h"


#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "YLTopic.h"
#import "YLTopicCell.h"
#import "YLCommentViewController.h"

@interface YLTopicViewController ()
/**
 *  请求管理者
 */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/**
 *  所有帖子的数据
 */
@property (strong, nonatomic) NSMutableArray *topics;
/**
 *  加载下一页的数据
 */
@property (copy, nonatomic) NSString *maxtime;
@end

@implementation YLTopicViewController
/**实现这个方法的目的只是为了消除警告（因为子类的type方法最终会覆盖父类的type方法）*/
- (YLTopicType)type
{
    return 0;
}

static NSString *const ID = @"topicCell";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

/*
 1.要想让一个scrollView的内容能够穿透整个屏幕
 1> 让scrollView的frame占据整个屏幕
 
 2.要想让用户能看清楚所有的内容，不被导航栏和tabbar挡住
 1> 设置scrollView的contentInset属性
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setuptable];
    
    [self setupRefresh];
}

- (void)setuptable
{
    
    self.tableView.backgroundColor = YLCommonBgColor;
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(YLNavBarMaxY + YLTitleHeight, 0, YLTabBarHeight, 0);
    //设置右边滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //注册cell
    [self.tableView registerNib: [UINib nibWithNibName:NSStringFromClass([YLTopicCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    
}
- (void)setupRefresh
{
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    //自动改变透明度
    self.tableView.header.automaticallyChangeAlpha = YES;
    
    //马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    //上啦刷新
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}
/**
 *  加载最新帖子数据
 */
- (void)loadNewTopics
{
    //取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSDictionary *parameters = @{
                                 @"a":@"list",
                                 @"c":@"data",
                                 @"type":@(self.type)
                                 
                                 };
    
    YLWeadSelf;
    [self.manager GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask *tast, id responseObject) {
        //       YLWriteToPlist(responseObject, @"topics");
        
        
        //字典转模型
        weakSelf.topics = [YLTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //储存maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [weakSelf.tableView.header endRefreshing];
        
    } failure:^ void(NSURLSessionDataTask * tast, NSError * error) {
        YLLog(@"私奔");
        
        //结束刷新
        [weakSelf.tableView.header endRefreshing];
    }];
    
}
/**
 *  加载更多
 */
- (void)loadMoreTopics
{
    //取消之前所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    
    YLWeadSelf;
    [self.manager GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask *task, id responseObject) {
        
        //字典数组 -> 模型数组
        NSArray *moreTopics = [YLTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [weakSelf.topics addObjectsFromArray:moreTopics];
        //储存maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        //刷新表格数据
        [self.tableView reloadData];
        //结束上啦刷新
        [self.tableView.footer endRefreshing];
        
    } failure:^ void(NSURLSessionDataTask *task, NSError *error) {
        
        //结束上啦刷新
        [self.tableView.footer endRefreshing];
    }];
    
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YLTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    cell.topic = self.topics[indexPath.row];;
    
    return cell;
}

//选中一行cell时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中cell时的选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    YLCommentViewController *commentVc = [[YLCommentViewController alloc]init];
    
    commentVc.topic = self.topics[indexPath.row];
    
    [self.navigationController pushViewController:commentVc animated:YES];
}
//计算cell高度会调用
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLTopic *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
}
@end
