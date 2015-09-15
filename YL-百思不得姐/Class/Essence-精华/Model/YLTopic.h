//
//  YLTopic.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/15.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLTopic : NSObject
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *profile_image;
/**
 *  帖子内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  顶的数量
 */
@property (nonatomic,assign)NSInteger ding;
/**
 *  踩的数量
 */
@property (nonatomic,assign)NSInteger cai;
/**
 *  转发数量
 */
@property (nonatomic,assign)NSInteger repost;
/**
 *  评论数
 */
@property (nonatomic,assign)NSInteger comment;
/**
 *  帖子审核通过的时间
 */
@property (nonatomic,copy)NSString *created_at;
@end
