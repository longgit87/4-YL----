//
//  YLComment.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/19.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLUser;
@interface YLComment : NSObject
/** 文字内容 */
@property (nonatomic, copy) NSString *content;
/** YLUser模型 */
@property (nonatomic, strong) YLUser *user;
@end
