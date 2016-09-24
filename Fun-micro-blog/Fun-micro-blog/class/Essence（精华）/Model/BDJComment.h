//
//  BDJComment.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/1.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BDJUser;
@interface BDJComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) BDJUser *user;
@end
