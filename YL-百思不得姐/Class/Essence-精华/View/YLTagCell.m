//
//  YLTagCell.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/6.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTagCell.h"
#import "YLTag.h"
#import <UIImageView+WebCache.h>

@interface YLTagCell ()
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *theme_label;
/**
 *  关注数
 */
@property (weak, nonatomic) IBOutlet UILabel *sub_label;

@end

@implementation YLTagCell
/**
 * 重写这个方法的目的：拦截cell的frame设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];

}
/**
 *  给cell子控件赋值
 */
- (void)setTagModel:(YLTag *)tagModel
{
    _tagModel = tagModel;
    
    
    
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:tagModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.theme_label.text = tagModel.theme_name;
    
    if (tagModel.sub_number.intValue >= 10000) {
        self.sub_label.text = [NSString stringWithFormat:@"%.2f万人订阅",tagModel.sub_number.intValue / 10000.0];
    }else
    {
    
       self.sub_label.text = [NSString stringWithFormat:@"%zd人订阅",tagModel.sub_number.intValue];
    }


}

@end
