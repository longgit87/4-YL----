//
//  YLTextField.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/13.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLTextField : UITextField
/**
 *  点击删除键要做的操作
 */
@property (nonatomic, copy) void (^deleteBackwardOperation)();

@end
