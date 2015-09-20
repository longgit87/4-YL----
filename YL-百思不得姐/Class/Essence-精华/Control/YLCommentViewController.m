//
//  YLCommentViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/19.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLCommentViewController.h"
#import "YLCommentCell.h"
#import "YLTopicCell.h"
#import "YLTopic.h"
#import "YLComment.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>

@interface YLCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
/**最热评论*/
@property (strong, nonatomic) NSArray *hotComments;
/**最新评论*/
@property (strong, nonatomic) NSMutableArray *latestComments;

/**暂时存储最热评论*/
@property (strong, nonatomic) YLComment *topComment;

/**请求管理者*/
@property (weak, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation YLCommentViewController

static NSString *ID = @"comment";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.autoresizingMask = UIViewAutoresizingNone;
  
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:@"comment_nav_item_share_icon" hightImage:@"comment_nav_item_share_icon_click" target:nil action:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
  
    [self setupTable];
    
    [self setupRefresh];
}
- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    [self.tableView.header beginRefreshing];

}
/**下拉刷新*/
- (void)loadNewComments
{
    //取消先前的所有刷新
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
   
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"hot"] = @1;
    
    YLWeadSelf;
    [self.manager GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask *task, id responseObject) {
        //最热评论
        weakSelf.hotComments = [YLComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        weakSelf.latestComments = [YLComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //刷新表格
        [weakSelf.tableView reloadData];
        //停止刷新
        [weakSelf.tableView.header endRefreshing];

    } failure:^ void(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf.tableView.header endRefreshing];
    }];
}
/**上拉刷新*/
- (void)loadMoreComments
{

    

}
- (void)setupTable
{
    self.tableView.backgroundColor = YLCommonBgColor;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YLCommentCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    //处理模型数据
    if (self.topic.topComment) {
       
        self.topComment = self.topic.topComment;
        self.topic.topComment = nil;
        self.topic.cellHeight = 0;
    }

    //自动调整cell的高度
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //设置headView
    YLTopicCell  *cellView = [YLTopicCell viewFromXib];
    cellView.topic = self.topic;
    cellView.frame = CGRectMake(0, 0, YLScreenW, self.topic.cellHeight);
    
    UIView *headView = [[UIView alloc]init];
    headView.height = cellView.height + 2 * YLCommonMargin;
    headView.backgroundColor = [UIColor redColor];
    [headView addSubview:cellView];
    
    self.tableView.tableHeaderView = headView;
    

}

//监听键盘的弹出
- (void)keyboardWillDidChangeFrame:(NSNotification *)note
{
    self.bottomSpace.constant = YLScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
 
    CGFloat time = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time animations:^{
        
        [self.view layoutIfNeeded];
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //恢复最热评论
    if (self.topComment) {
        self.topic.topComment = self.topComment;
        self.topic.cellHeight = 0;
    }
    
}
//开始要拖动tableview的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count) return 2;
    if (self.latestComments.count) return 1;

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.hotComments.count) {
        return self.hotComments.count;
    }
    return self.latestComments.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //取出对应模型
    NSArray *comments = self.latestComments;
    if (indexPath.section == 0 && self.hotComments.count) {
        comments = self.hotComments;
    }
    cell.comment = comments[indexPath.row];

    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0 && self.hotComments.count) {
        return @"热门评论";
    }
  return @"最新评论";
}
@end
