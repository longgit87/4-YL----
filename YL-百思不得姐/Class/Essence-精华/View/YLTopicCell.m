//
//  YLTopicCell.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/15.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTopicCell.h"
#import "YLTopic.h"
#import "YLTopicPictureView.h"
#import "YLTopicVideoView.h"
#import "YLTopicVioceView.h"



@interface YLTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage_imageV;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *createAt_label;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *ding_button;
@property (weak, nonatomic) IBOutlet UIButton *cai_button;
@property (weak, nonatomic) IBOutlet UIButton *repost_button;
@property (weak, nonatomic) IBOutlet UIButton *comment_button;

@property (weak, nonatomic) YLTopicPictureView *topicPictureV;
@property (weak, nonatomic) YLTopicVideoView *topicVideoV;
@property (weak, nonatomic) YLTopicVioceView *topVoiceV;
@end

@implementation YLTopicCell

- (YLTopicPictureView *)topicPictureV
{
    if (!_topicPictureV) {
        
        YLTopicPictureView *topicPictureV = [YLTopicPictureView viewFromXib];
        [self.contentView addSubview:topicPictureV];
        
        _topicPictureV = topicPictureV;
    }

    return _topicPictureV;

}
- (YLTopicVideoView *)topicVideoV
{
    if (!_topicVideoV) {
        
        YLTopicVideoView *topicVideoV = [YLTopicVideoView viewFromXib];
        [self.contentView addSubview:topicVideoV];
        _topicVideoV = topicVideoV;
        
    }
    return _topicVideoV;
    
}
- (YLTopicVioceView *)topVoiceV
{
    if (!_topVoiceV) {
        
        YLTopicVioceView *topVoiceV = [YLTopicVioceView viewFromXib];
        [self.contentView addSubview:topVoiceV];
        _topVoiceV = topVoiceV;
        
    }
    return _topVoiceV;

}


- (void)awakeFromNib
{
    //设置cell的背景图片
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.autoresizingMask = UIViewAutoresizingNone;

}

- (void) setTopic:(YLTopic *)topic
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

    
    //设置底部工具条数据
    [self setupButtonTitle:self.ding_button number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.cai_button number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repost_button number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.comment_button number:topic.comment placeholder:@"评论"];
    
    
    //根据帖子的内容决定中间内容
    if (topic.type == YLTopicTypePicture) {//图片
        
        self.topicPictureV.hidden = NO;
        self.topicPictureV.frame = self.topic.contentFrame;
        self.topicPictureV.topic = topic;
        self.topicVideoV.hidden = YES;
        self.topVoiceV.hidden = YES;
        
    }else if (topic.type == YLTopicTypeVideo){//视频
        self.topicVideoV.hidden = NO;
        self.topicVideoV.frame = self.topic.contentFrame;
        self.topicVideoV.topic = topic;
        self.topicPictureV.hidden = YES;
        self.topVoiceV.hidden = YES;
        
    }else if (topic.type == YLTopicTypeVoice){//声音
        self.topVoiceV.hidden = NO;
        self.topVoiceV.frame = topic.contentFrame;
        self.topVoiceV.topic = topic;
        self.topicPictureV.hidden = YES;
        self.topicVideoV.hidden = YES;
        
    }else if (topic.type == YLTopicTypeWord){//文字
        self.topicPictureV.hidden = YES;
        self.topicVideoV.hidden = YES;
        self.topVoiceV.hidden = YES;
        
    }
    
   
   
}


/**设置工具条按钮的文字*/
- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    
    if (number >= 10000) {
        
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
        
    }else if (number > 0){
        
    
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
     
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
   
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += 10;
    frame.size.height -= 10;

    [super setFrame:frame];
}
- (IBAction)moreClick {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        YLLog(@"收藏");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        YLLog(@"举报");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        YLLog(@"取消");
    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}
@end
