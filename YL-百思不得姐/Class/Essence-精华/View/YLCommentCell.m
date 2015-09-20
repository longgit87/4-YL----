//
//  YLCommentCell.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/19.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLCommentCell.h"
#import "YLComment.h"
#import "YLUser.h"

@interface YLCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@end

@implementation YLCommentCell

- (void)awakeFromNib {

//    self.autoresizingMask = NO;
    
    

}

- (void)setComment:(YLComment *)comment
{
    _comment = comment;
    
    //如果有语音
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd",comment.voicetime] forState:UIControlStateNormal];
    }else{
        
        self.voiceButton.hidden = YES;
    }

    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
    //判断性别
    if ([comment.user.sex isEqualToString:@"m"]) {
        [self.sexView setImage:[UIImage imageNamed:@"Profile_manIcon"]];
    }else{
    
        [self.sexView setImage:[UIImage imageNamed:@"Profile_womanIcon"]];
    }
    
    //用户头像
    [self.profileImageView setHeaderIcon:comment.user.profile_image];
    
}

@end
