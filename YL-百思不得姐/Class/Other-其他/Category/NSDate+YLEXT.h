//
//  NSDate+YLEXT.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/15.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YLEXT)
- (NSDateComponents *)intervalToDate:(NSDate *)date;

- (NSDateComponents *)intervalToNow;
/**
   是否为今年
 */
- (BOOL)isThisYear;
/**
 *  是否为今天
 */
- (BOOL)isThisDay;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为明天
 */
- (BOOL)isTomorrow;
@end
