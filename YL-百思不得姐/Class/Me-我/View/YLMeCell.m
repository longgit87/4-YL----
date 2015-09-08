//
//  YLMeCell.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/7.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLMeCell.h"

@implementation YLMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.tintColor = [UIColor darkGrayColor];

        //设置背景图片
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    
    return self;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    //调整imageview
    self.imageView.y = YLCommonMargin * 0.5;
    self.imageView.height = self.contentView.height - 2 * self.imageView.y;
    self.imageView.width = self.imageView.height;
    
    //调整label
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + YLCommonMargin;
    
}

@end
