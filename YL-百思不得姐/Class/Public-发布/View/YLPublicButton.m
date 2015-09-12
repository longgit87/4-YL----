//
//  YLPublicButton.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/9.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLPublicButton.h"

@implementation YLPublicButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

    }

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    
    //图片
    self.imageView.x = self.width * 0.2;
    self.imageView.y = self.height * 0.15;
    
     //文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 10;
    self.titleLabel.width = self.width;
    

}
@end
