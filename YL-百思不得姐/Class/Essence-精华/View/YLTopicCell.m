//
//  YLTopicCell.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/15.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTopicCell.h"
#import "YLTopic.h"


@interface YLTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage_imageV;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *createAt_label;
@property (weak, nonatomic) IBOutlet UILabel *text_label;


@end

@implementation YLTopicCell


- (void)setTopic:(YLTopic *)topic
{
    _topic = topic;
    
    //头像
    [self.profileImage_imageV setHeaderIcon:topic.profile_image];
    //昵称
    self.name_label.text = topic.name;
    //审核时间
    self.createAt_label.text = topic.created_at;
    //内容
    self.text_label.text = topic.text;

}



@end
