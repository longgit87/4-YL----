//
//  YLTopic.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/15.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTopic.h"


@implementation YLTopic

- (NSString *)created_at
{
    //日期格式化类
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yy-MM-dd HH:mm:ss";
    
    // NSString -> NSDate
    NSDate *createdData = [formatter dateFromString:_created_at];
    
    //比较【发帖时间】和【手机当前时间】差值
   NSDateComponents *components = [createdData intervalToNow];
    
    if (createdData.isThisYear) {
        
        if (createdData.isThisDay) {//今天
            
            if (components.hour >= 1) {// 时间差距 >= 1小时
                
                return [NSString stringWithFormat:@"%zd小时前",components.hour];
                
            }else if (components.minute >= 1){// 1分钟 =< 时间差距 <= 59分钟
            
                return [NSString stringWithFormat:@"%zd分钟前",components.minute];
            }else{
                
                return @"刚刚";
            }
        }else if (createdData.isYesterday){// 昨天
            formatter.dateFormat = @"昨天 HH-mm-ss";
            return [formatter stringFromDate:createdData];
        
        }else{// 今年的其他时间
            formatter.dateFormat = @"MM-dd HH-mm-ss";
            return [formatter stringFromDate:createdData];
        }
        
    }else{// 非今年
    
        return _created_at;
    }
    
}

@end
