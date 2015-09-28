//
//  YLUserCell.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/27.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLUserCell.h"
#import <UIImageView+WebCache.h>
#import "YLFollowUser.h"


@interface YLUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *header_imageView;
@property (weak, nonatomic) IBOutlet UILabel *screenName_label;
@property (weak, nonatomic) IBOutlet UILabel *fansCount_label;

@end
@implementation YLUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFollowUser:(YLFollowUser *)followUser
{
    _followUser = followUser;
    YLLog(@"%@",followUser.screen_name);
    
    [self.header_imageView setHeaderIcon:followUser.header];
    
    self.screenName_label.text = followUser.screen_name;
    
    if (followUser.fans_count.intValue >= 10000) {
        self.fansCount_label.text = [NSString stringWithFormat:@"%.2f万人关注",followUser.fans_count.intValue / 10000.0];
    }else{
    
        self.fansCount_label.text = [NSString stringWithFormat:@
                                     "%zd人关注",followUser.fans_count.intValue];
    
    }
    

}
@end
