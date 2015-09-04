//
//  UIBarButtonItem+EXT.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/1.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (EXT)
/**创建导航栏左边按钮*/
+ (instancetype)itemWithimage:(NSString *)image hightImage:(NSString *)hightImage target:(id)target action:(SEL)action;

@end
