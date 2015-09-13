//
//  YLPostWordViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/9.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLPostWordViewController.h"
#import "YLPlaceholderTextView.h"
#import "YLAddTagToolBar.h"

@interface YLPostWordViewController ()<UITextViewDelegate>
@property (weak, nonatomic) YLPlaceholderTextView *textView;
@property (weak, nonatomic) YLAddTagToolBar *bar;

@end

@implementation YLPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YLCommonBgColor;
    //设置导航栏
    [self setupNavigation];
    //设置textView
    [self setupTextView];
    //设置toolbar
    [self setupToolBar];
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{

    //键盘弹出后最终的位置
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //弹出键盘所用的时间
    CGFloat time = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:time animations:^{

        self.bar.transform = CGAffineTransformMakeTranslation(0, rect.origin.y - YLScreenH);

    }];
}
- (void)setupToolBar
{
    
    YLAddTagToolBar *bar = [YLAddTagToolBar toolBar];
    bar.width = YLScreenW;
    bar.y = YLScreenH - bar.height;
    [self.view addSubview:bar];

    self.bar = bar;
    
    
    
    
    //监听键盘的弹出点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];


}
//设置导航栏
- (void)setupNavigation
{

    //标题
    self.title = @"发表文字";
    //左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    //右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //强制刷新，马上刷新现在的状态
    [self.navigationController.navigationBar layoutIfNeeded];

}

//设置textView
- (void)setupTextView
{

    YLPlaceholderTextView *textView = [[YLPlaceholderTextView alloc]init];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.delegate = self;
    textView.frame = self.view.bounds;
    textView.y = 64;
    textView.alwaysBounceVertical = YES;//让内容可以向下拖拽
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:textView];

    self.textView = textView;
    //成为第一响应者，弹出键盘
    [self.textView becomeFirstResponder];

}
- (void)post
{

    YLLog(@"%@",self.textView.text);

}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;

    
}
@end
