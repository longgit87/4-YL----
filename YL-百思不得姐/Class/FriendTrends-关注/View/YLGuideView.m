//
//  YLGuideView.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/4.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLGuideView.h"

@implementation YLGuideView
+ (instancetype)guideView
{
    return[[[NSBundle mainBundle] loadNibNamed:@"YLGuideView" owner:nil options:nil] lastObject];
}
+ (void)show
{

    NSString *key = @"CFBundleShortVersionString";
    //拿到当前软件版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获取沙盒储存的版本号
    NSString *sanVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (![currentVersion isEqualToString:sanVersion]) {
        
        YLGuideView *v = [YLGuideView guideView];
        v.frame = window.bounds;
        [window addSubview:v];
    }
    //储存当前版本号
    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKeyPath:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
//
//+ (void)show
//{
//     NSString *key = @"CFBoundleShortVersionString";
//    
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
//    
//    NSString *sanVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
//    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    
//    
//    if (![currentVersion isEqualToString:sanVersion]) {
//        YLGuideView *guide = [YLGuideView guideView];
//        guide.frame = window.bounds;
//        [window addSubview:guide];
//    }
//    
//    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKeyPath:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];

//    NSString *key = @"CFBoundleShortVersionString";
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
//    NSString *sanVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if (![currentVersion isEqualToString:sanVersion]) {
//        YLGuideView *guide = [YLGuideView guideView];
//        guide.frame = window.bounds;
//        [window addSubview:guide];
//    }
//    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKeyPath:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];

//    NSString *key = @"CFBundleShortVersionString";
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
//    NSString *sanVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if (![currentVersion isEqualToString:sanVersion]) {
//        YLGuideView *guide = [YLGuideView guideView];
//        guide.frame = window.bounds;
//        [window addSubview:guide];
//    }
//    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];

//    NSString *key = @"CFBoundleShortVersionString";
//    NSString *curentVersion = [NSBundle mainBundle].infoDictionary[key];
//    NSString *sanVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if (![curentVersion isEqualToString:sanVersion]) {
//        YLGuideView *guide = [YLGuideView guideView];
//        guide.frame = window.bounds;
//        [window addSubview:guide];
//    }
//    [[NSUserDefaults standardUserDefaults] setValue:curentVersion forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    NSString *key = @"CFBoundleShortVersionString";
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
//    NSString *sanVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if (![currentVersion isEqualToString:sanVersion]) {
//        YLGuideView *guide = [YLGuideView guideView];
//        guide.frame = window.bounds;
//        [window addSubview:guide];
//    }
//    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    NSString *key = @"CFBoundleShortVersionString";
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
//    NSString *sanVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if (![currentVersion isEqualToString:sanVersion]) {
//        YLGuideView *guide = [YLGuideView guideView];
//        guide.frame = window.bounds;
//        [window addSubview:guide];
//    }
//    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    NSString *key = @"CFBoundleShortVersionString";
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
//    NSString *sanVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if (![currentVersion isEqualToString:sanVersion]) {
//        YLGuideView *guide = [YLGuideView guideView];
//        guide.frame = window.bounds;
//        [window addSubview:guide];
//    }
//    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//}
//点击我知道了按钮
- (IBAction)IKnow:(id)sender {
    
    [self removeFromSuperview];
}

@end
