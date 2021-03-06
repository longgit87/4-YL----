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
#import "YLCommentHeaderView.h"
#import "YLUser.h"

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

/** 写方法声明的目的是为了使用点语法提示 */
@property (strong, nonatomic) YLComment *selectComment;

@end

@implementation YLCommentViewController

static NSString *ID = @"comment";
static NSString *const headerViewId = @"header";

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
 
        //判读返回的数据是否为数组（如果没有评论数据了，服务器会返回一个空数组）
        if ([responseObject isKindOfClass:[NSArray class]]) {
            //结束刷新
            [weakSelf.tableView.header endRefreshing];
            return;
        }

        //最热评论
        weakSelf.hotComments = [YLComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        weakSelf.latestComments = [YLComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //刷新表格
        [weakSelf.tableView reloadData];
        //停止刷新
        [weakSelf.tableView.header endRefreshing];
        
        // 已经加载完毕
        if (self.latestComments.count >= [responseObject[@"total"] intValue]){
        
            self.tableView.footer.hidden = YES;
            self.tableView.footer = nil;
            [self.tableView reloadData];
        }
     

    } failure:^ void(NSURLSessionDataTask *task, NSError *error) {
        //结束刷新
        [weakSelf.tableView.header endRefreshing];
    }];
}
/**上拉刷新*/
- (void)loadMoreComments
{

    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    YLWeadSelf;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"lastcid"] = [self.latestComments.lastObject ID];

    [self.manager GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask *task , id responseObject) {
       
//        if (self.latestComments.count >= [responseObject[@"total"] intValue]) {
//            [weakSelf.tableView.footer endRefreshing];
//            return;
//            
//        }

        //获取请求到的下一页数据
        NSArray *newComments = [YLComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //添加到最新评论数组
        [weakSelf.latestComments addObjectsFromArray:newComments];
        
        //刷新表格
        [weakSelf.tableView reloadData];
        
        //判断是否已经加载完全
        if (self.latestComments.count >= [responseObject[@"total"] intValue]) {
            //已经加载完毕
            weakSelf.tableView.footer.hidden = YES;
            weakSelf.tableView.footer = nil;
            [self.tableView reloadData];
        }else{//应该还会有下一页
            
            // 结束刷新(恢复到普通状态，仍旧可以继续刷新)
            [weakSelf.tableView.footer endRefreshing];
        }
        
        
    } failure:^ void(NSURLSessionDataTask * task, NSError * error) {
        
        //结束刷新
        [weakSelf.tableView.footer endRefreshing];
        
    }];

}
- (void)setupTable
{
    
    self.tableView.backgroundColor = YLCommonBgColor;
    self.tableView.separatorStyle = UITableViewRowAnimationNone;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YLCommentCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    
    [self.tableView registerClass:[YLCommentHeaderView class] forHeaderFooterViewReuseIdentifier:headerViewId];
    
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
//组头View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

     YLCommentHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];

    if (section == 0 && self.hotComments.count) {
        headerView.text = @"最热评论";
  
    }else{
    headerView.text = @"最近评论";
    }
    return headerView;

}
//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出点击的cell
    YLCommentCell *cell = (YLCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    UIMenuController *menuC = [UIMenuController sharedMenuController];
    
    menuC.menuItems = @[
                        [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)],
                        [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(reply:)],
                        [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(warning:)]
                        ];
    CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, 0);
    
    [menuC setTargetRect:rect inView:cell];


    [menuC setMenuVisible:YES animated:YES];
}
//可以成为第一响应者
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
//允许显示的弹框内容
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (!self.isFirstResponder) {//文本框弹出键盘，文本框是第一响应者
        
        if (action == @selector(ding:)
            ||action == @selector(reply:)
            ||action == @selector(warning:)
            ) {
            return NO;
        }
        
    }
    return [super canPerformAction:action withSender:sender];
}


- (YLComment *)selectComment
{

    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    NSInteger row = indexPath.row;
    NSArray *comments = self.latestComments;
    if (indexPath.section == 0 && self.hotComments.count) {
        comments = self.hotComments;
    }
    
  return comments[row];

}
- (void)ding:(UIMenuController *)item
{

    
    YLLog(@"顶 - %@ ：%@",self.selectComment.user.username,self.selectComment.content);
}
- (void)reply:(UIMenuController *)item
{

    YLLog(@"回复 - %@ : %@",self.selectComment.user.username,self.selectComment.content);
    
}
- (void)warning:(UIMenuController *)item
{
    YLLog(@"举报 - %@ : %@",self.selectComment.user.username,self.selectComment.content);
}
@end
