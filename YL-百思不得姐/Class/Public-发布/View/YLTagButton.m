//
//  YLTagButton.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/12.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTagButton.h"

@implementation YLTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = YLColor(57, 116, 201);
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        
    }
    return self;
}
//重写为了做微调
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    //自动计算label尺寸
    [self sizeToFit];
    //微调
    self.height = YLTagHeight;
    self.width += 3 * YLCommonSmallMargin;
 

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = YLCommonSmallMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + YLCommonSmallMargin;

}
@end

