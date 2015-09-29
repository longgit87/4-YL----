//
//  YLRecommendFollowViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/26.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLRecommendFollowViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "YLCategory.h"
#import "YLCategoryCell.h"
#import "YLUserCell.h"
#import "YLFollowUser.h"
#import <SVProgressHUD.h>

@interface YLRecommendFollowViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  左边tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/**
 *  右边tableview
 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/**
 *  请求管理者
 */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/**
 *  左边类别数组
 */
@property (strong, nonatomic) NSMutableArray *categories;
/**
 *  页码
 */
@property (nonatomic, assign) int page;

@end

@implementation YLRecommendFollowViewController

static NSString *const categoryId = @"category";
static NSString *const userId = @"user";


#pragma mark - lazy

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
    
    [self getCategoryData];
    
    
    
}
- (void)setupTable
{
    
    self.view.backgroundColor = YLCommonBgColor;
    self.title = @"推荐关注";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets inset = UIEdgeInsetsMake(YLNavBarMaxY, 0, 0, 0);
    
    //左边
    self.categoryTableView.contentInset = inset;
    self.categoryTableView.scrollIndicatorInsets = inset;
    self.categoryTableView.separatorStyle = UITextAutocapitalizationTypeNone;
    [self.categoryTableView registerNib:[UINib nibWithNibName: NSStringFromClass([YLCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryId];
   
    //右边

    self.userTableView.rowHeight = 70;
    self.userTableView.contentInset = inset;
    self.userTableView.scrollIndicatorInsets = inset;
    self.userTableView.separatorStyle = UITextAutocapitalizationTypeNone;
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YLUserCell class]) bundle:nil] forCellReuseIdentifier:userId];
    
    

}

- (void)setupRefresh
{
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
}

- (void)dealloc
{
    //取消所有的请求
    [self.manager invalidateSessionCancelingTasks:YES];
  
}

- (void)getCategoryData
{
    //蒙版框
    [SVProgressHUD show];
    
    //请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    YLWeadSelf;
    //请求
    [self.manager GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask *task, id responseObject) {
        
//        YLWriteToPlist(responseObject, @"category");
        weakSelf.categories = [YLCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.categoryTableView reloadData];
        
        //蒙板框消失
        [SVProgressHUD dismiss];
        //主动点击第一个cell
        [weakSelf.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //让右边进入下拉刷新
        [weakSelf.userTableView.header beginRefreshing];
        
    } failure:^ void(NSURLSessionDataTask *task, NSError *error) {
        
        YLLog(@"标签加载失败");
    
        
    }];


}
//加载数据
- (void)loadNewUsers
{
    //取消以前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    
    //取出左边选中的对应的模型
    YLCategory *selectCategory = self.categories[self.categoryTableView.indexPathForSelectedRow.row];

    parameters[@"category_id"] = selectCategory.ID;


    //请求
    YLWeadSelf;
    [self.manager GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask *task, id responseObject) {
        
//        YLWriteToPlist(responseObject, @"users");
        
        //重置页码为1
        selectCategory.page = 1;
        //储存用户组到模型中
        selectCategory.users = [YLFollowUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //储存这组用户的总数量
        selectCategory.total = [responseObject[@"total"] intValue];
        //刷新右边表格
        [weakSelf.userTableView reloadData];
        
        //结束刷新
        [weakSelf.userTableView.header endRefreshing];
        
        //判断是否加载完全
        if (selectCategory.users.count >= selectCategory.total) {
            weakSelf.userTableView.footer.hidden = YES;

        }
        
    } failure:^ void(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf.userTableView.header endRefreshing];
    }];

}
//加载下一页
- (void)loadMoreUsers
{
  
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    
    //拿到点击类别cell对应的类别模型
    YLCategory *selectCategory = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    
    parameters[@"category_id"] = selectCategory.ID;
    
    NSInteger page = selectCategory.page + 1;//刷新一次页码+1
    parameters[@"page"] = @(page);
    
    YLWeadSelf;
    //请求
    [self.manager GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask *task, id responseObject) {
        //设置当前最新页码
        selectCategory.page = page;
        
        //字典->模型
        NSArray *moreUsers = [YLFollowUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加最新模型数组到原来的模型数组
        [selectCategory.users addObjectsFromArray:moreUsers];
        
        //刷新
        [weakSelf.userTableView reloadData];
        
        //如果加载完全
        if (selectCategory.users.count >= [responseObject[@"total"] intValue]) {
            weakSelf.userTableView.footer.hidden = YES;
            
        }
        //结束底部刷新
        [weakSelf.userTableView.footer endRefreshing];
        
        
        
    } failure:^ void(NSURLSessionDataTask *task, NSError *error) {
        //结束底部刷新
        [weakSelf.userTableView.footer endRefreshing];
        
    }];
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {//左边行数
        
        return self.categories.count;
    }else{ //右边行数

         YLCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];

    return category.users.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (tableView == self.categoryTableView) {//左边cell
        
        
        YLCategoryCell *categoryCell = [self.categoryTableView dequeueReusableCellWithIdentifier:categoryId];
        
        categoryCell.category = self.categories[indexPath.row];
        
       
        return categoryCell;
    }else{//右边cell
    
    YLUserCell *userCell = [self.userTableView dequeueReusableCellWithIdentifier:userId];

        YLCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        userCell.followUser = category.users[indexPath.row];


    return userCell;
    }

}

//点击了cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {//点击了左边表格
        
        //刷新用户表格
        [self.userTableView reloadData];
        
        //拿到该cell的模型
        YLCategory *selectCategory = self.categories[indexPath.row];
        //判断footer是否要隐藏
        if (selectCategory.users.count >= selectCategory.total) {
            self.userTableView.footer.hidden = YES;
        }
        
        //判断是否有过用户数据
        if (selectCategory.users.count == 0) {//还没有过用户数据
            
            [self.userTableView.header beginRefreshing];
        }
        
        
        
    }else{//点击了右边用户表格
    
        YLLog(@"点击了右边--%zd",indexPath.row);
    
    }
    
}
@end
