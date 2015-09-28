//
//  YLCategory.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/26.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLCategory : NSObject
/** 标签名称 */
@property (nonatomic, copy) NSString *name;
/** 标签id */
@property (nonatomic, copy) NSString *ID;
/** 用户数 */
@property (nonatomic, copy) NSString *count;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;

@end
