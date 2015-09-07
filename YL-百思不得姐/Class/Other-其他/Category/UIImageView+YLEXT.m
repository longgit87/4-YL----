//
//  UIImageView+YLEXT.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/7.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "UIImageView+YLEXT.h"
#import "UIImage+YLEXT.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (YLEXT)

- (void)setHeaderIcon:(NSString *)iconUrl
{

    [self setCircleHeaderIcon:iconUrl];
    
}
//设置圆形头像
- (void)setCircleHeaderIcon:(NSString *)iconUrl
{

    UIImage *placeImage = [UIImage circleImage:@"defaultUserIcon"];
    
    YLWeadSelf;
    [self sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:placeImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 如果图片下载失败，就不做任何处理，按照默认的做法：会显示占位图片
        if (image == nil) return;
        
        weakSelf.image = [image circleImage];
        
    }];


}
//设置方形头像
- (void)setRectHeaderIcon:(NSString *)iconUrl
{

    [self sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

}
@end
