
//
//  YLClearCacheCell.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/8.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLClearCacheCell.h"
#import <SVProgressHUD.h>


#define YLCacheFile [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"default"]

@implementation YLClearCacheCell

static NSString *const YLDefaultText = @"清除缓存";


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //禁止点击事件
        self.userInteractionEnabled = NO;
        
        //右边显示圈圈
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;

        
        //计算缓存大小
        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
            
            NSString *sizeText = nil;
            CGFloat unit = 1000.0;
            
            NSInteger size = [YLCacheFile fileSize];
           
            if (size >= unit * unit * unit) {// >= 1GB

                sizeText = [NSString stringWithFormat:@"%.2fGB",size / unit / unit / unit];
            }else if (size >= unit *unit){// >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB",size / unit / unit];
            }else if (size >= unit){// >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB",size / unit];
            } else{// >= 0B
                sizeText = [NSString stringWithFormat:@"%zdB",size];
            }
            NSString *text = [NSString stringWithFormat:@"%@(%@)",YLDefaultText,sizeText];
            
            //回到主线程刷新
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.textLabel.text = text;
            //右边箭头
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.accessoryView = nil;
            //允许点击
            self.userInteractionEnabled = YES;
            
         }];

      }];
        
    }


    return self;
}
//清除缓存
- (void)clearCache
{

    [SVProgressHUD showWithStatus:@"正在清除缓存" maskType:SVProgressHUDMaskTypeBlack];
    [[[NSOperationQueue alloc]init] addOperationWithBlock:^{
        
        
        [[NSFileManager defaultManager] removeItemAtPath:YLCacheFile error:nil];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //显示成功蒙版
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            
            self.textLabel.text = YLDefaultText;
            
            //禁止点击
            self.userInteractionEnabled = NO;
            
        }];
        
    }];


}
@end
