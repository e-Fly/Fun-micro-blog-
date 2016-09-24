//
//  BDJTopic.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/23.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDJConst.h"
@interface BDJTopic : NSObject

/** id*/
@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图片的URL*/
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL*/
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL*/
@property (nonatomic, copy) NSString *large_image;
/** 帖子的类型*/
@property (nonatomic, assign) BDJTopicType type;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;
/** 评论*/
@property (nonatomic, strong) NSArray *top_cmt;



/**  辅助属性*/
/**  cell的高度*/
@property (nonatomic, assign) CGFloat cellHeight;
/** 图片空间的frame */
@property (nonatomic, assign) CGRect pictureF;
/** 声音空间的frame */
@property (nonatomic, assign) CGRect voiceF;
/** 视频空间的frame */
@property (nonatomic, assign) CGRect videoF;

/** 判读是不是大图 */
@property (nonatomic, assign) BOOL bigImage;
/** 下载进度 */
@property (nonatomic, assign) CGFloat progress;
/** 热门评论的告诉 */
@property (nonatomic, assign) CGFloat CommentHeight;


@end
