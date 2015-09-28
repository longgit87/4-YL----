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
//- (NSMutableArray *)categories
//{
//    if (!_categories) {
//        _categories = [NSMutableArray array];
//    }
//    
//    return _categories;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupTable];
    
    
    [self setupRefresh];
    [self getCategoryData];
    
    
    
}
- (void)setupTable
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets inset = UIEdgeInsetsMake(YLNavBarMaxY, 0, 0, 0);
    
    //左边
    self.categoryTableView.backgroundColor = YLCommonBgColor;
    self.categoryTableView.contentInset = inset;
    self.categoryTableView.scrollIndicatorInsets = inset;
    self.categoryTableView.separatorStyle = UITextAutocapitalizationTypeNone;
    [self.categoryTableView registerNib:[UINib nibWithNibName: NSStringFromClass([YLCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryId];
   
    //右边
    self.userTableView.backgroundColor = YLCommonBgColor;
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
        
    } failure:^ void(NSURLSessionDataTask *task, NSError *error) {
        
        YLLog(@"标签加载失败");
    
        
    }];

}
//加载数据
- (void)loadNewUsers
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    
    //取出左边选中的对应的模型
    YLCategory *selectCategory = self.categories[self.categoryTableView.indexPathForSelectedRow.row];

    parameters[@"category_id"] = selectCategory.ID;


    YLWeadSelf;
    [self.manager GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask *task, id responseObject) {
        
//        YLWriteToPlist(responseObject, @"users");
        //储存用户组到模型中
        selectCategory.users = [YLFollowUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [weakSelf.userTableView reloadData];
        
        //结束刷新
        [weakSelf.userTableView.header endRefreshing];
        
    } failure:^ void(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf.userTableView.header endRefreshing];
    }];

}
//加载下一页
- (void)loadMoreUsers
{
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        
        return self.categories.count;
    }else{

         YLCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];

    return category.users.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (tableView == self.categoryTableView) {//左边
        
        
        YLCategoryCell *categoryCell = [self.categoryTableView dequeueReusableCellWithIdentifier:categoryId];
        
        categoryCell.category = self.categories[indexPath.row];
        
       
        return categoryCell;
    }else{//右边
    
    YLUserCell *userCell = [self.userTableView dequeueReusableCellWithIdentifier:userId];

        YLCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        userCell.followUser = category.users[indexPath.row];


    return userCell;
    }

}
//点击了cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        [self.userTableView reloadData];
        
        [self.userTableView.header beginRefreshing];
    }
    
}
@end
