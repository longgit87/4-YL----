//
//  YLAddTagToolBar.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/10.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLAddTagToolBar.h"
#import "YLAddTagViewController.h"

@interface YLAddTagToolBar ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *topView;
/**所有标签的label*/
@property (strong, nonatomic) NSMutableArray *tagLabels;
/**加号按钮*/
@property (weak, nonatomic) UIButton *addBtn;
/**顶部高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@end

@implementation YLAddTagToolBar

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

+ (instancetype)toolBar
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib
{

    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    //监听点击
    [btn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentImage.size;
    
    [self.topView addSubview:btn];

    self.addBtn = btn;
    
    //默认传递两个标签
    [self createTagLabels:@[@"吐槽",@"糗事"]];

}
//点击添加标签
- (void)addClick
{
    YLWeadSelf;
    YLAddTagViewController *tagViewcontrol = [[YLAddTagViewController alloc]init];
    //储存block要操作的代码
    tagViewcontrol.getTagsBlock = ^(NSArray *tags){
        [weakSelf createTagLabels:tags];
    
    };
    tagViewcontrol.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    YLNavigationControl *nav = [[YLNavigationControl alloc]initWithRootViewController:tagViewcontrol];
    UIViewController *vc = self.window.rootViewController.presentedViewController;
    

    [vc presentViewController:nav animated:YES completion:nil];
    
}
/**
 *  创建label
 */
- (void)createTagLabels:(NSArray *)tags
{

     // 让self.tagLabels数组中的所有对象执行removeFromSuperview方法
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    

    for (int i = 0; i < tags.count; i++) {
        
        //创建label
        UILabel *newLabel = [[UILabel alloc]init];
        newLabel.text = tags[i];
        newLabel.font = [UIFont systemFontOfSize:17];
        newLabel.backgroundColor = YLTagBgColor;
        newLabel.textColor = [UIColor whiteColor];
        newLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.topView addSubview:newLabel];
        [self.tagLabels addObject:newLabel];
        
        //尺寸
        [newLabel sizeToFit];//让系统自己先算好尺寸
        newLabel.height = YLTagHeight;
        newLabel.width += 2 * YLCommonSmallMargin;
        
    }
    //重新布局子控件
    [self setNeedsLayout];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.tagLabels.count; i++) {
       
        //创建label
        UILabel *newLabel = self.tagLabels[i];
      
    //位置
    if (i == 0) {
        
        newLabel.x = 0;
        newLabel.y = 0;
        
    }else{
        
        //上一个标签
        UILabel *previousTagLabel = self.tagLabels[i - 1];
        CGFloat leftWidth = CGRectGetMaxX(previousTagLabel.frame) + YLCommonSmallMargin;
        CGFloat rightWidth = self.topView.width - leftWidth;
        
        if (rightWidth >= newLabel.width) {//同一行
            
            newLabel.x = leftWidth;
            newLabel.y = previousTagLabel.y;
        }else{//不同行
            
            newLabel.x = 0;
            newLabel.y = CGRectGetMaxY(previousTagLabel.frame) + YLCommonSmallMargin;
            
        }
        
    }
  }
    
    //加号按钮
    UILabel *lastLabel = self.tagLabels.lastObject;
    if (lastLabel) {
        
        CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + YLCommonSmallMargin;
        CGFloat rightWidth = self.topView.width - leftWidth;
        if (rightWidth >= self.addBtn.width) {
            
            self.addBtn.x = leftWidth;
            self.addBtn.y = lastLabel.y;
        }else{
            self.addBtn.x = 0;
            self.addBtn.y = CGRectGetMaxY(lastLabel.frame) + YLCommonSmallMargin;
            
        }
        
    }else{
        
        self.addBtn.x = 0;
        self.addBtn.y = 0;
    }
    

    //计算topView的高度
    self.topViewHeight.constant = CGRectGetMaxY(self.addBtn.frame) + YLCommonSmallMargin;
    CGFloat oldHeight = self.height;
    self.height = self.topViewHeight.constant + self.bottomView.height + YLCommonSmallMargin;
    self.y += oldHeight - self.height;

}
@end
