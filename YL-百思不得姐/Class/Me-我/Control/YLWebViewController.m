//
//  YLWebViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/8.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLWebViewController.h"
#import "YLSquare.h"

@interface YLWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardBtn;

@end

@implementation YLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.square.name;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.square.url]]];
    
    self.view.backgroundColor = YLCommonBgColor;
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);



}
- (IBAction)back:(id)sender {
    [self.webView goBack];
}

- (IBAction)forward:(id)sender {
    [self.webView goForward];
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    self.backBtn.enabled = self.webView.canGoBack;
    self.forwardBtn.enabled = self.webView.canGoForward;
    
}
@end
