//
//  YLCategoryCell.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/27.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLCategoryCell.h"
#import "YLCategory.h"

@interface YLCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *indicator;

@end
@implementation YLCategoryCell

- (void)awakeFromNib {

    self.selectionStyle = UITextAutocapitalizationTypeNone;
    
    
}

- (void)setCategory:(YLCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;


}
//选中cell和取消选中都会调用这个方法
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.textLabel.textColor = selected ? [UIColor redColor] : [UIColor darkGrayColor];
    self.indicator.hidden = selected ? NO : YES;
    
}
@end
