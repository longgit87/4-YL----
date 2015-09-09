//
//  UIImage+YLEXT.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/7.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "UIImage+YLEXT.h"

@implementation UIImage (YLEXT)

- (instancetype)circleImage
{
    //开启位图上下文
    UIGraphicsBeginImageContext(self.size);
    //获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    //添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    //裁剪圆--裁剪成刚才添加的图形形状
    CGContextClip(ctx);
    //在圆的上面画一张图片
    [self drawInRect:rect];
    //获得上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
    
    
}



+ (instancetype)circleImage:(NSString *)imageName
{
    return [[self imageNamed:imageName] circleImage];
}
@end
