//
//  YLTopic.h
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/15.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  enum {
    /** 图片 */
    YLTopicTypePicture = 10,
    /** 段子(文字) */
    YLTopicTypeWord = 29,
    /** 声音 */
    YLTopicTypeVoice = 31,
     /** 视频 */
    YLTopicTypeVideo = 41

} YLTopicType;

@interface YLTopic : NSObject
/**昵称*/
@property (nonatomic, copy) NSString *name;
/**头像*/
@property (nonatomic, copy) NSString *profile_image;
/**帖子内容*/
@property (nonatomic, copy) NSString *text;
/**顶的数量*/
@property (nonatomic,assign)NSInteger ding;
/**踩的数*/
@property (nonatomic,assign)NSInteger cai;
/**转发数量*/
@property (nonatomic,assign)NSInteger repost;
/**评论数*/
@property (nonatomic,assign)NSInteger comment;
/**帖子审核通过的时间*/
@property (nonatomic,copy)NSString *created_at;
/**图片的宽度*/
@property (nonatomic,assign)CGFloat width;
/**图片的高度*/
@property (nonatomic,assign)CGFloat height;
/**帖子的类型*/
@property (nonatomic,assign) YLTopicType type;

/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 大图 */
@property (nonatomic, copy) NSString *image1;
/** 中图 */
@property (nonatomic, copy) NSString *image2;

/** 是否为动态图 */
@property (nonatomic, assign) BOOL is_gif;

/***************额为增加的属性**********************/

/**cell的高度*/
@property (nonatomic,assign)CGFloat cellHeight;
/**中间内容的frame*/
@property (nonatomic,assign)CGRect contentFrame;
/**是否为大图*/
@property (nonatomic,assign, getter=isBigPicture)BOOL bigPicture;


@end
