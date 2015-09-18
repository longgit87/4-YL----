//
//  YLSeeBigPictureViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/18.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLSeeBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "YLTopic.h"
#import <SVProgressHUD.h>

@interface YLSeeBigPictureViewController ()<UIScrollViewDelegate>


@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation YLSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];

    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:scrollView atIndex:0];

    scrollView.delegate = self;

    //图片
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1]];
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //图片尺寸
    imageView.x = 0;
    imageView.width = YLScreenW;
    //图片原来高度 * 图片缩放后宽度  / 图片原来的宽度 = 图片缩放后的高度
    imageView.height = self.topic.height * YLScreenW / self.topic.width;
    
    if (self.topic.height > YLScreenH) {//图片大于屏幕高度
        imageView.y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.height);
        
    }else{
    
       imageView.centerY = YLScreenH * 0.5;
    }
    //伸缩
    CGFloat maxScale = self.topic.height / imageView.height;
    if (maxScale > 0) {
        scrollView.maximumZoomScale = maxScale;
    }

}
//保存图片
- (IBAction)save {
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
//    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
//    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    [self presentViewController:picker animated:YES completion:nil];
//    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
     
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }

}
- (IBAction)back {
    
    [self dismissViewControllerAnimated:NO completion:^{
        
        
    }];
}
#pragma mark - UIScrollViewDelegate
//缩放scrollView内部的哪个控件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
