//
//  YLCommentHeaderView.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/22.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLCommentHeaderView.h"

@interface YLCommentHeaderView ()
/** 内部的label */
@property (weak, nonatomic) UILabel *label;
@end

@implementation YLCommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = YLCommonBgColor;
        
        //label
        UILabel *label = [[UILabel alloc]init];

        label.x = YLCommonMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.textColor = YLGrayColor(120);
        label.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:label];
        
        self.label = label;
    }
    return self;

}

- (void)setText:(NSString *)text
{
    
    _text = [text copy];
    self.label.text = text;
    
}
@end
