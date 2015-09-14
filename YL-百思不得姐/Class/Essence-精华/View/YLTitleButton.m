//
//  YLTitleButton.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/13.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTitleButton.h"

@implementation YLTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}


- (void)setHighlighted:(BOOL)highlighted
{

}
@end
