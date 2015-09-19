//
//  YLTopic.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/15.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTopic.h"
#import <MJExtension.h>


@implementation YLTopic

+ (NSDictionary *)replacedKeyFromPropertyName
{

    return @{
        @"small_image":@"image0",
        @"large_image":@"image1",
        @"middle_image":@"image2",
        @"ID":@"id"
    };
}

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

- (CGFloat)cellHeight
{
   
    if (!_cellHeight) {
    
    _cellHeight = YLTextY;
   
    //计算文字内容高度
    CGFloat textW = YLScreenW - 2 * YLCommonMargin;
    CGSize textSize = CGSizeMake(textW, MAXFLOAT);
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGFloat textH = [_text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;

    _cellHeight += textH + YLCommonMargin;
    //中间内容的高度
    if (self.type != YLTopicTypeWord) {
        
        CGFloat contentW = textW;
        
        //图片的高度 * 内容的宽度 / 图片的宽度
        CGFloat contentH = self.height * contentW / self.width;
        
        if (contentH > YLScreenH) {//图片高度超屏幕就定义为大图   设置高度为200
            
            contentH = 200;
            
            self.bigPicture = YES;//保存为 是大图！
        }
        
        CGFloat contentX = YLCommonMargin;
        CGFloat contentY =  _cellHeight;
        
        self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
        
        _cellHeight += contentH + YLCommonMargin;
        
    }
    
        //最热评论
        NSDictionary *cmt = self.top_cmt.firstObject;
        if (cmt) {
            NSString *userName = cmt[@"user"][@"username"];
            NSString *topContent = cmt[@"content"];
            NSString *cmtText = [NSString stringWithFormat:@"%@ : %@",userName,topContent];
            
            //文字内容高度
            CGFloat topCmtContentH = [cmtText boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
            
            _cellHeight += YLTopCmtTitleH + topCmtContentH + YLCommonMargin;
        }
        
        //不管有没图片都是要加底部工具条高度
        _cellHeight += YLTopicToolBarH + YLCommonMargin;

  }
    
    
    return  _cellHeight;
    
}


@end
