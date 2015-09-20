//
//  YLTopicVideoView.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/18.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTopicVideoView.h"
#import "YLTopic.h"
#import <UIImageView+WebCache.h>
#import "YLSeeBigPictureViewController.h"

@interface YLTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCount_label;

@property (weak, nonatomic) IBOutlet UILabel *videoTime_label;

@end

@implementation YLTopicVideoView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)]];
   
    
    

}
- (void)clickImage
{
//    if (self.imageView.image == nil) return;
    YLSeeBigPictureViewController *seeBigPictureVc = [[YLSeeBigPictureViewController alloc]init];
    seeBigPictureVc.topic = self.topic;
    
    [self.window.rootViewController presentViewController:seeBigPictureVc animated:YES completion:nil];


}


- (void)setTopic:(YLTopic *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCount_label.text = [NSString stringWithFormat:@"%zd播放",self.topic.playcount];

    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTime_label.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];


}

@end
