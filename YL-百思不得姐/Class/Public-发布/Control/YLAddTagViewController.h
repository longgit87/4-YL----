//
//  YLAddTagViewController.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/11.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLAddTagViewController : UIViewController
/** 传递tag数据的block, block的参数是一个字符串数组 */
@property (nonatomic, copy) void(^getTagsBlock)(NSArray *);
/**
 *  从上个界面传过来的标签数据
 */
@property (nonatomic, strong) NSArray *tags;
@end
