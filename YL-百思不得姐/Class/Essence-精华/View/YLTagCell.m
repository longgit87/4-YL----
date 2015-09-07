//
//  YLTagCell.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/6.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTagCell.h"
#import "YLTag.h"

#import "UIImageView+YLEXT.h"

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
    
    //设置头像
    [self.icon_image setHeaderIcon:tagModel.image_list];
    
    //设置标题文字
    self.theme_label.text = tagModel.theme_name;
    
    //设置订阅数
    if (tagModel.sub_number.intValue >= 10000) {
        self.sub_label.text = [NSString stringWithFormat:@"%.2f万人订阅",tagModel.sub_number.intValue / 10000.0];
    }else
    {
    
       self.sub_label.text = [NSString stringWithFormat:@"%zd人订阅",tagModel.sub_number.intValue];
    }


}

@end
