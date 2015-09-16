//
//  NSDate+YLEXT.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/15.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "NSDate+YLEXT.h"

@implementation NSDate (YLEXT)

- (NSDateComponents *)intervalToDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSCalendarUnit unit =   NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:self toDate:date options:0];
}

- (NSDateComponents *)intervalToNow
{
    return [self intervalToDate:[NSDate date]];
}

/**
 是否为今年
 */
- (BOOL)isThisYear
{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;

}
/**
 *  是否为今天
 */
- (BOOL)isThisDay
{

    NSCalendar *canendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cmps = [canendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [canendar components:unit fromDate:self];
    
    
    return cmps.year == selfCmps.year
           && cmps.month == selfCmps.month
           && cmps.day == selfCmps.day;
}
/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    
    //获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    //比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *coms = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    
    return coms.year == 0
    && coms.month == 0
    && coms.day == 1;


}
/**
 *  是否为明天
 */
- (BOOL)isTomorrow
{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    //比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
    
}
@end
