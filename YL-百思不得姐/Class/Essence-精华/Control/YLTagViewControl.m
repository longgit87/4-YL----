//
//  YLTagViewControl.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTagViewControl.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "YLTagCell.h"
#import "YLTag.h"

@interface YLTagViewControl ()

@property (strong, nonatomic) NSArray *tagModels;
@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation YLTagViewControl


static NSString *tagId = @"tag";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的标签";
    
    [self setUpTable];
    [self setUploadData];
    
    
    
}
- (void)setUpTable
{

    //设置cell行高
    self.tableView.rowHeight = 80;
    self.tableView.backgroundColor = YLCommonBgColor;
    //取消系统自带的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YLTagCell class]) bundle:nil] forCellReuseIdentifier:tagId];
    
    
}

//请求数据、赋值
- (void)setUploadData
{

    //弹框
    [SVProgressHUD show];
    
    //请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    //发送请求
    

    YLWeadSelf;
    [self.manager GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask *task, id responseObject) {
        
        // responseObject：字典数组
        // weakSelf.tags：模型数组
        // responseObject -> weakSelf.tags
        
        weakSelf.tagModels = [YLTag objectArrayWithKeyValuesArray:responseObject];
        [weakSelf.tableView reloadData];
        //关闭弹框
        [SVProgressHUD dismiss];
        
    } failure:^ void(NSURLSessionDataTask * task, NSError * error) {
        
        
        //如果取消了任务就不叫失败，直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        if (error.code == NSURLErrorTimedOut) {//超时
            
            [SVProgressHUD showErrorWithStatus:@"加载标签数据超时，请稍后再试！"];
            
        }else{
            
            
            [SVProgressHUD showErrorWithStatus:@"加载标签失败"];
            
        }
        
        
    }];

}
- (void)dealloc
{
    //停止请求
    [self.manager invalidateSessionCancelingTasks:YES];
    
    [SVProgressHUD dismiss];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tagModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagId];
 
    
    cell.tagModel = self.tagModels[indexPath.row];

    return cell;
}
@end
