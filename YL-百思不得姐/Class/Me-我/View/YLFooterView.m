//
//  YLFooterView.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/7.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLFooterView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YLSquare.h"
#import "YLSquareBtn.h"
#import "YLWebViewController.h"


@interface YLFooterView ()



@end


@implementation YLFooterView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
         self.backgroundColor = YLCommonBgColor;
        
        //请求参数
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"a"] = @"square";
        parameters[@"c"] = @"topic";
      
       
        
        //发送请求
        YLWeadSelf;
        [[AFHTTPSessionManager manager] GET:YLRequestUrl parameters:parameters success:^ void(NSURLSessionDataTask * task, id responseObject) {
          
            [weakSelf createSquaresWithArray:[YLSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]]];

            
        } failure:^ void(NSURLSessionDataTask * task, NSError * error) {
            
            
        }];
        
        for (int index = 0; index < 16; index++) {
            
            UIButton *btn = [[YLSquareBtn alloc]init];

            
            [self addSubview:btn];
            
        }
 
    }

    return self;
}

- (void)createSquaresWithArray:(NSArray *)squares
{
    NSInteger count = squares.count;
    
    int colCount = 4;
    CGFloat w = self.width / colCount;
    CGFloat h = w * 1.1;
    
    
    for (int i = 0; i < count; i++) {
        //第几行列
        int col = i % colCount;
        int row = i / colCount;
        
        YLSquareBtn *btn = self.subviews[i];
        btn.square = squares[i];
        
        CGFloat x = col * w;
        CGFloat y = row * h;
        btn.frame = CGRectMake(x, y, w, h);
        
        //添加监听按钮点击
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
//        self.height = CGRectGetMaxY(btn.frame);
    }
    //设置footerview的高度
    NSUInteger rowCount = (count + colCount - 1) / colCount;
    self.height = rowCount * h;
    
//    //重新设置footerview
    UITableView *tableVeiw = (UITableView *)self.superview;
    tableVeiw.contentSize = CGSizeMake(0, CGRectGetMaxY(self.frame));
    

    
}
- (void)clickBtn:(YLSquareBtn *)btn
{
    //因为我们只能请求http的数据（这里是针对该app接口的特殊情况）
    if ([btn.square.url hasPrefix:@"http"] == NO) return;

    YLWebViewController *webVc = [[YLWebViewController alloc]init];
    webVc.square = btn.square;

    //拿到tabbar控制器
    UITabBarController *rootVc = (UITabBarController *)self.window.rootViewController;
    //拿到tabbar控制器当前选中的导航控制器
    UINavigationController *nav = (UINavigationController *)rootVc.selectedViewController;
    //跳转到对应控制器
    [nav pushViewController:webVc animated:YES];



}

@end
