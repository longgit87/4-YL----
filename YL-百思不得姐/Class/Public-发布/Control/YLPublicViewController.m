//
//  YLPublicViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/9.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLPublicViewController.h"
#import "YLPublicButton.h"
#import <POP.h>

@interface YLPublicViewController ()
/**
 *  按钮
 */
@property (strong, nonatomic) NSMutableArray *buttons;
/**
 *  标语
 */
@property (weak, nonatomic) UIImageView *sloganView;
/**
 *  动画时间
 */
@property (strong, nonatomic) NSArray *times;

@end

@implementation YLPublicViewController

static CGFloat const YLSpringFactor = 10;

- (NSArray *)times
{
    if (!_times) {
        
        CGFloat interval = 0.05;
        _times = @[@(interval * 0),
                   @(interval * 2),
                   @(interval * 1),
                   @(interval * 3),
                   @(interval * 4),
                   @(interval * 5),
                   @(interval * 6),//标语的动画时间（保证在最后）
                   ];
    }
    return _times;
}

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //禁止用户交互
    self.view.userInteractionEnabled = NO;
    
    //添加标语
    [self setupButtons];
    
    //添加标语
    [self setupSloganView];

    
}

//按钮
- (void)setupButtons
{

    //添加按钮
    //按钮数组
    NSArray *imageNames = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *labelTexts = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //一些参数
    NSInteger count = imageNames.count;
    NSInteger colCount = 3;//总列数
    NSInteger rowCount = (count + colCount - 1) / colCount;//有多少行
    CGFloat btnW = YLScreenW / 3;
    CGFloat btnH = btnW;
    CGFloat btnStartY = (YLScreenH - btnH * rowCount) * 0.5;
    
    for (int i = 0; i < count; i++) {
        
        UIButton *btn = [[YLPublicButton alloc]init];
        
        btn.width = -1; // 按钮的尺寸为0，还是能看见文字缩成一个点，设置按钮的尺寸为负数，那么就看不见文字了
        [btn setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        [btn setTitle:labelTexts[i] forState:UIControlStateNormal];
        
        //按钮位置
        
        CGFloat btnX = (i % colCount) * btnW;
        CGFloat btnY = (i / colCount) * btnH + btnStartY;
        
        //添加监听
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttons addObject:btn];
        [self.view addSubview:btn];
        
        //动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        

        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY - YLScreenH, btnW, btnH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btnW, btnH)];
        anim.springSpeed = YLSpringFactor;
        anim.springBounciness = YLSpringFactor;
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [btn pop_addAnimation:anim forKey:nil];
        
    }
  
}
//标语
- (void)setupSloganView
{

    //添加标语
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    
    CGFloat sloganY = 0.2 * YLScreenH;
    
    sloganView.y = sloganY - YLScreenH;
    sloganView.centerX = YLScreenW * 0.5;
    [self.view addSubview:sloganView];
    self.sloganView = sloganView;
    
    //动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    anim.toValue = @(sloganY);
    anim.springSpeed = YLSpringFactor;
    anim.springBounciness = YLSpringFactor;
    // CACurrentMediaTime()获得的是当前时间
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //允许用户交互
        self.view.userInteractionEnabled = YES;
        
    }];
    [sloganView.layer pop_addAnimation:anim forKey:nil];


    

}
//取消
- (IBAction)cancel:(UIButton *)btn {
    
    self.view.userInteractionEnabled = NO;
    //按钮消失
    for (int i = 0; i < self.buttons.count; i++) {
        
        YLPublicButton *publicBtn = self.buttons[i];
    
    //动画
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    anim.toValue = @(publicBtn.layer.position.y + YLScreenH) ;
//    anim.springSpeed = YLSpringFactor;
//    anim.springBounciness = YLSpringFactor;
    anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
    [publicBtn.layer pop_addAnimation:anim forKey:nil];
    
   }
    
    YLWeadSelf;
    //标语动画
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(self.sloganView.layer.position.y + YLScreenH);
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];

    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
      
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }];
    [self.sloganView.layer pop_addAnimation:anim forKey:nil];

    
}
//点击按钮
- (void)btnClick:(UIButton *)btn
{
    [self cancel:btn];
}
@end
