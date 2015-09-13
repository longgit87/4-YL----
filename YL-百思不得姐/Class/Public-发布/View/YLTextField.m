//
//  YLTextField.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/13.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTextField.h"

@implementation YLTextField
//重写小删除的方法
- (void)deleteBackward
{
    
    !self.deleteBackwardOperation ? : self.deleteBackwardOperation();

    [super deleteBackward];

}

@end
