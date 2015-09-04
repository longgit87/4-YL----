//
//  YLNavigationControl.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/2.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLNavigationControl.h"

@interface YLNavigationControl ()<UIGestureRecognizerDelegate>

@end

@implementation YLNavigationControl
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count >= 1) {
        
    //设置导航栏左边按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    //让内容填充按钮
    [btn sizeToFit];
    //监听按钮点击
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //移动按钮内容的位置
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);

    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //跳转时隐藏tabbar
    viewController.hidesBottomBarWhenPushed = YES;
    
    }
    // 设置子控制器的颜色
    //    viewController.view.backgroundColor = XMGCommonBgColor;
    
    // super的push方法一定要写到最后面
    // 一旦调用super的pushViewController方法,就会创建子控制器viewController的view
    // 也就会调用viewController的viewDidLoad方法


    [super pushViewController:viewController animated:animated];


}
/**
 * 每当用户触发[返回手势]时都会调用一次这个方法
 * 返回值:返回YES,手势有效; 返回NO,手势失效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{

    // 如果当前显示的是第一个子控制器,就应该禁止掉[返回手势]
    //    if (self.childViewControllers.count == 1) return NO;
    //    return YES;
    return self.childViewControllers.count > 1;

}
- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
