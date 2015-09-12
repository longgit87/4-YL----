
//
//  YLAddTagViewController.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/11.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLAddTagViewController.h"
#import "YLTagButton.h"

@interface YLAddTagViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) UIView *contentView;
@property (weak, nonatomic) UITextField *textField;
@property (weak, nonatomic) UIButton *tipBtn;
@property (strong, nonatomic) NSMutableArray *tagButtons;
@end

@implementation YLAddTagViewController

- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        
        _tagButtons = [NSMutableArray array];
    }

    return _tagButtons;
}

- (UIButton *)tipBtn
{
    if (!_tipBtn) {
     
        //创建提醒按钮
        UIButton *tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tipBtn.backgroundColor = YLColor(57, 116, 201);
        tipBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        //监听提醒按钮点击
        [tipBtn addTarget:self action:@selector(tipBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        tipBtn.x = 0;
        tipBtn.width = self.contentView.width;
        tipBtn.height = YLTagHeight;
        //内容左对齐
        tipBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //左边设置间距
        tipBtn.contentEdgeInsets = UIEdgeInsetsMake(0, YLCommonSmallMargin, 0, 0);
        
        [self.contentView addSubview:tipBtn];

        _tipBtn = tipBtn;
    }
    return _tipBtn;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏
    [self setupNav];
    //设置装文本等内容的父控件View
    [self setupContentView];
    //设置文本框
    [self setupTextField];
    
 
}

- (void)setupTextField
{

    UITextField *textField = [[UITextField alloc]init];
    textField.x = 0;
    textField.y = 0;
    textField.width = self.contentView.width;
    textField.height = YLTagHeight;
    //设置占位文字和颜色
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.placeholderColor = [UIColor grayColor];
    
    textField.delegate = self;
    
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.contentView addSubview:textField];
     // 刷新的前提：这个控件已经被添加到父控件
    [textField layoutIfNeeded];

    //成为第一响应者
    [textField becomeFirstResponder];
    
    self.textField = textField;
    
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc]init];
    contentView.x = YLCommonMargin;
    contentView.y = YLNavBarMaxY + YLCommonMargin;
    contentView.width = YLScreenW - 2 * contentView.x;
    contentView.height = YLScreenH - YLNavBarMaxY;
    
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupNav
{
     self.title = @"添加标签";
    //添加导航栏左右两边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];

}
#pragma mark - 监听
/**
 *  监听文本框文字改变
 */
- (void)textDidChange
{
    if (self.textField.hasText) {//文本框有文字
        
        //获取输入的最后一个字符
        NSString *text = self.textField.text;
        NSString *lastChar = [text substringFromIndex:text.length - 1];
        
        if ([lastChar isEqualToString:@","] || [lastChar isEqualToString:@"，"]) {//最后一个字符是逗号
           
           //去掉文本框最后一个字符（逗号）
            self.textField.text = [text substringToIndex:text.length - 1];
            //点击提醒按钮
            [self tipBtnClick];
            
        }else{//最后一个字符不是逗号的情况
           
            //排布文本框
            
            //获得字符串的长度
            NSDictionary *attrs = @{NSFontAttributeName:self.textField.font};
            CGFloat textW = [text sizeWithAttributes:attrs].width;
            
            //右边剩余长度
            UIButton *lastBtn = self.tagButtons.lastObject;
            CGFloat rightW = self.contentView.width - CGRectGetMaxX(lastBtn.frame);
            
            if (textW > rightW) {//输入框文字超出剩余空间，要换行
                
                self.textField.x = 0;
                self.textField.y = CGRectGetMaxY(lastBtn.frame) + YLCommonSmallMargin;
                
            }
       
        }
        
        self.tipBtn.hidden = NO;
        self.tipBtn.y = CGRectGetMaxY(self.textField.frame) + YLCommonMargin;
        [self.tipBtn setTitle:[NSString stringWithFormat:@"添加标签：%@",self.textField.text] forState:UIControlStateNormal];
    }else{//文本框没有文字
        
        self.tipBtn.hidden = YES;
    }
    
}
/**
 *  监听提醒按钮的点击
 *
 */
- (void)tipBtnClick
{
    if (self.textField.hasText == NO) return;
   //创建标签按钮
    UIButton *newTagButton = [YLTagButton buttonWithType:UIButtonTypeCustom];

    [newTagButton addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [newTagButton setTitle:self.textField.text forState:UIControlStateNormal];

    [self.contentView addSubview:newTagButton];
    //最后一个按钮
    UIButton *lastBtn = self.tagButtons.lastObject;
    
    
    if (lastBtn) {//不是第一个按钮
        
               //要添加新标签时左边已经被占用的长度
        CGFloat leftWidth = CGRectGetMaxX(lastBtn.frame) + YLCommonSmallMargin;
        //右边剩余宽度
        CGFloat rightWidth = self.contentView.width - leftWidth;
        if (newTagButton.width <= rightWidth) { //要添加的新按钮不需要换行
            newTagButton.x = CGRectGetMaxX(lastBtn.frame) + YLCommonSmallMargin;
            newTagButton.y = lastBtn.y;
            
        }else{//要换行
            newTagButton.x = 0;
            newTagButton.y = CGRectGetMaxY(lastBtn.frame) + YLCommonSmallMargin;
            
            self.tipBtn.y = CGRectGetMaxY(newTagButton.frame) + YLCommonMargin;
        }
        
    }else{//是第一按钮
    
        newTagButton.x = 0;
        newTagButton.y = 0;
        
    }
    
        //添加按钮到数组
        [self.tagButtons addObject:newTagButton];

    
        //布局textfield
    CGFloat leftWidth = CGRectGetMaxX(newTagButton.frame) + YLCommonSmallMargin;
    CGFloat rightWidth = self.contentView.width - leftWidth;
    if (rightWidth < 100) {//文本框要换行
        self.textField.y = CGRectGetMaxY(newTagButton.frame) + YLCommonMargin;
        self.textField.x = 0;

    }else{//文本框不用换行
        self.textField.y = newTagButton.y;
        self.textField.x = leftWidth;
    }
    
    self.textField.text = nil;
    
        //隐藏提醒按钮
        self.tipBtn.hidden = YES;

}
/**
 *  点击删除标签
 *
 */
- (void)tagBtnClick:(UIButton *)tagBtn
{
    //即将被删除的标签按钮的索引
    NSInteger index = [self.tagButtons indexOfObject:tagBtn];
    //从父控件中删除按钮，并从数组中删除
    [tagBtn removeFromSuperview];
    [self.tagButtons removeObject:tagBtn];

    for (NSInteger i = index; i < self.tagButtons.count; i++) {
        
        YLTagButton *btn = self.tagButtons[i];
        
        
        if (i > 0) {//不是第一个按钮
            
            YLTagButton *previousBtn = self.tagButtons[i-1];
            
            CGFloat leftWidth = CGRectGetMaxX(previousBtn.frame) + YLCommonSmallMargin;
            CGFloat rightWidth = self.contentView.width - leftWidth;
            
            if (btn.width <= rightWidth) {//同一行
                btn.x = leftWidth;
                btn.y = previousBtn.y;
            }else{//不同行
                
                btn.x = 0;
                btn.y = CGRectGetMaxY(previousBtn.frame) + YLCommonSmallMargin;
                
            }
            
            
        }else{//是第一个按钮
        
            btn.x = 0;
            btn.y = 0;
        
        }
       
        
    }
    
}
//取消
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
//完成
- (void)done
{


}
/**
 *  点击键盘右下角的return会调用这个方法
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [self tipBtnClick];
    
    return YES;
}
@end
