//
//  YLSquareBtn.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/7.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLSquareBtn.h"
#import <UIButton+WebCache.h>
#import "YLSquare.h"

@implementation YLSquareBtn

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        //设置有边线的图片
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        //初始化文字的属性
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }

    return self;
}
- (void)setSquare:(YLSquare *)square
{
    _square = square;
    
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];

    //设置标题
    [self setTitle:square.name forState:UIControlStateNormal];

}
//布局内部图片和文字的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    //图片
    self.imageView.width = self.width * 0.6;
    self.imageView.height = self.height * 0.55;
    self.imageView.x = self.width * 0.2;
    self.imageView.y = self.height * 0.1;
    //文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;

}
@end
