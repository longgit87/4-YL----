//
//  YLUser.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/19.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLUser : NSObject
/** 用户昵称 */
@property (nonatomic, copy) NSString *username;
/** 用户性别 */
@property (nonatomic, copy) NSString *sex;
/** 用户头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
