//
//  NSString+YLEXT.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/7.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "NSString+YLEXT.h"

@implementation NSString (YLEXT)

- (NSInteger)fileSize
{
     //文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    //是否为文件夹
    BOOL isDirectory = NO;
    //这个文件夹是否存在
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    //路径不存在
    if (exists == NO) return 0;
    
    if (isDirectory) {//是文件夹
        //总大小
        NSInteger size = 0;
        //获得文件夹中的所有内容
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            //获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            //获得文件属性
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
            
        }
        return size;
    }else{//是文件
        
        return [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
    
    
}


@end
