//
//  YLCommentViewController.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/19.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLTopic,YLComment;

@interface YLCommentViewController : UIViewController

@property (nonatomic, strong) YLTopic *topic;
/** 评论模型 */
@property (nonatomic, strong) YLComment *comment;

@end
