//
//  YLUserCell.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/27.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLFollowUser;

@interface YLUserCell : UITableViewCell
/** 推荐用户模型 */
@property (nonatomic, strong) YLFollowUser *followUser;

@end
