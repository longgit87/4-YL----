//
//  YLLoginRegisterViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/3.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLLoginRegisterViewController.h"

@interface YLLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginRegister;
- (IBAction)loginRegisterClick:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeftView;

@end

@implementation YLLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
}
//显示白色状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//关闭登录注册页面
- (IBAction)closeLoginRegister:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
//点击退出键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//点击注册登录按钮
- (IBAction)loginRegisterClick:(id)sender {
    
    self.loginLeftView.constant = -self.view.width;
//    [self.view layoutIfNeeded];
    
}
@end
