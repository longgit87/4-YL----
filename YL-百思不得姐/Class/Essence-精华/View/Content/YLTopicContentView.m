//
//  YLTopicContentView.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/22.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTopicContentView.h"
#import "YLSeeBigPictureViewController.h"
@interface YLTopicContentView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation YLTopicContentView

- (void)awakeFromNib
{
    // 清空自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.clipsToBounds = YES;
       //添加点击图片事件
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView)]];

}
/**点击了图片*/
- (void)clickImageView
{
    if (self.imageView.image == nil) return;
    
    YLSeeBigPictureViewController *seeBigPictureVc = [[YLSeeBigPictureViewController alloc]init];
    
    //给看大图控制器传入模型
    seeBigPictureVc.topic = self.topic;
    
    [self.window.rootViewController presentViewController:seeBigPictureVc animated:YES completion:nil];
}

@end
