//
//  YLTopicVioceView.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/18.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTopicVioceView.h"
#import "YLTopic.h"
#import "YLSeeBigPictureViewController.h"

@interface YLTopicVioceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCount_label;
@property (weak, nonatomic) IBOutlet UILabel *vocieTime_label;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end
@implementation YLTopicVioceView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)]];

}
- (void)clickImage
{
    YLSeeBigPictureViewController *seeBigPictureVc = [[YLSeeBigPictureViewController alloc]init];
    seeBigPictureVc.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBigPictureVc animated:YES completion:nil];
    
}

- (void)setTopic:(YLTopic *)topic
{
    _topic = topic;
    
    self.playCount_label.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.vocieTime_label.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];

}

@end
