//
//  YLTopicPictureView.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/16.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLTopicPictureView.h"
#import "YLTopic.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>

@interface YLTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation YLTopicPictureView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //设置进度条一些属性
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];

}

- (void)setTopic:(YLTopic *)topic
{

    [super setTopic:topic];


    YLWeadSelf;
    //下载图片
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {

        //每下载一点图片数据，就会调一次这个block
        weakSelf.progressView.hidden = NO;
       
        weakSelf.progressView.progress = 1.0 * receivedSize / expectedSize;
        
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",weakSelf.progressView.progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //图片下载完会调用这个block
        weakSelf.progressView.hidden = YES;
        
    }];

    //控制显示大图按钮的显示
    self.seeBigPictureButton.hidden  = !topic.isBigPicture;

    //控制gif图标的显示
    self.gifView.hidden = !topic.is_gif;
    
    //判断是否为大图
    if (topic.bigPicture) {
        _imageView.contentMode = UIViewContentModeTop;
        _imageView.clipsToBounds = YES;
    }else{
    
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.clipsToBounds = NO;
    }
        
}

- (IBAction)clickSeeBigPicture {
    
    
}


@end
