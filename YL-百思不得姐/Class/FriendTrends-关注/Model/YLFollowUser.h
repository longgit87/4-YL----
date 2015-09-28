//
//  YLFollowUser.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/27.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLFollowUser : NSObject
/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 主此人名称 */
@property (nonatomic, copy) NSString *screen_name;
/** 粉丝数 */
@property (nonatomic,copy) NSString *fans_count;


@end
