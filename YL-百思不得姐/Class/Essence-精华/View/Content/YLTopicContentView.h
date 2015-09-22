//
//  YLTopicContentView.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/22.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLTopic;

@interface YLTopicContentView : UIView

{
    __weak UIImageView *_imageView;
}
/**帖子模型*/
@property (nonatomic, strong) YLTopic *topic;
@end
