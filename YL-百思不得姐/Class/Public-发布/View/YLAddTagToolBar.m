//
//  YLAddTagToolBar.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/10.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLAddTagToolBar.h"
#import "YLAddTagViewController.h"

@interface YLAddTagToolBar ()
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation YLAddTagToolBar

+ (instancetype)toolBar
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib
{

    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    //监听点击
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentImage.size;
    
    [self.topView addSubview:btn];


}
//点击添加标签
- (void)btnClick
{
    YLAddTagViewController *tagViewcontrol = [[YLAddTagViewController alloc]init];
    YLNavigationControl *nav = [[YLNavigationControl alloc]initWithRootViewController:tagViewcontrol];
    UIViewController *vc = self.window.rootViewController.presentedViewController;
    

    [vc presentViewController:nav animated:YES completion:nil];
    
}
@end
