//
//  YLTabBarController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTabBarController.h"
#import "YLMeViewController.h"
#import "YLNewViewController.h"
#import "YLFriendTrendsViewController.h"
#import "YLEssenceViewController.h"

#import "YLTabBar.h"

@interface YLTabBarController ()

@end

@implementation YLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //添加所有子控制器
    [self setUpChildVcs];
    
    //设置item
    [self setUpItem];
    
    //处理tabbar
    [self setUpTabBar];
    

}
/**
 *  设置item属性
 */
- (void)setUpItem
{

    //拿到全部的item来设置统一样式
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *nor = [NSMutableDictionary dictionary];
    nor[NSForegroundColorAttributeName] = [UIColor grayColor];
    nor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    NSMutableDictionary *sel = [NSMutableDictionary dictionary];
    sel[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    sel[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    [item setTitleTextAttributes:nor forState:UIControlStateNormal];
    [item setTitleTextAttributes:sel forState:UIControlStateSelected];
    


}
/**
 *  处理tabbar
 */
- (void)setUpTabBar
{

    [self setValue:[[YLTabBar alloc]init] forKeyPath:@"tabBar"];


}
/**
 *  添加自控制器
 */
- (void)setUpChildVcs
{

    
    
    //关注
    [self setUpChileViewWithVc:[[YLFriendTrendsViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    //精华
    [self setUpChileViewWithVc:[[YLEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    //新帖
    [self setUpChileViewWithVc:[[YLNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    
    //我
    [self setUpChileViewWithVc:[[YLMeViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];


}
/**
 *  添加一个子控制器
 *
 *  @param Vc          控制器
 *  @param title       文字
 *  @param image       图片
 *  @param selectImage 选中时的图片
 */
- (void)setUpChileViewWithVc:(UIViewController *)Vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    
    //包装成导航控制器
    YLNavigationControl *nav = [[YLNavigationControl alloc]initWithRootViewController:Vc];
    //处理渲染
    UIImage *img = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *seImg = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置图标文字
    [nav.tabBarItem setImage:img];
    [nav.tabBarItem setSelectedImage:seImg];
    
    [nav.tabBarItem setTitle:title];


   

    [self addChildViewController:nav];

}


@end
