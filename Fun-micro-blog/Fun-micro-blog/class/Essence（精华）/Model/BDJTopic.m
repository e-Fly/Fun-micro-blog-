//
//  BDJTopic.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/23.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJTopic.h"
#import "UIDate+BDJTimeTool.h"
#import "MJExtension.h"
#import "BDJConst.h"
#import "BDJUser.h"
#import "BDJComment.h"
@implementation BDJTopic
- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}
- (CGFloat)cellHeight
{
    CGFloat width = BDJBounds.size.width - 4 * 10;
    if (!_cellHeight) {
        CGFloat height = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
        _cellHeight = BDJTopicHeadH + BDJTopicMargin + height + BDJTopicMargin;
        
        CGFloat imageH = width * self.height / self.width;
        if (imageH >= BDJTopicPictureMaxH) {
            imageH = BDJTopicShowPictureH;
            self.bigImage = YES;
        }
        //图片
        if (self.type == BDJTopicTypePicture) {
            _cellHeight += imageH;
            _pictureF = CGRectMake(BDJTopicMargin,BDJTopicHeadH + BDJTopicMargin + height + BDJTopicMargin, width, imageH);
        }else if (self.type == BDJTopicTypeVoice)
        {
            _cellHeight += imageH;
            _voiceF =  CGRectMake(BDJTopicMargin,BDJTopicHeadH + BDJTopicMargin + height + BDJTopicMargin, width, imageH);
        }else if (self.type == BDJTopicTypeVideo)
        {
            _cellHeight += imageH;
            _videoF =  CGRectMake(BDJTopicMargin,BDJTopicHeadH + BDJTopicMargin + height + BDJTopicMargin, width, imageH);
        }
        
        BDJComment *cmt = [self.top_cmt firstObject];
        self.CommentHeight = 0;
        if (cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
             CGFloat height = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
            
            height += BDJTopicCellTopCmtTitleH;
            self.CommentHeight = height;
            _cellHeight += height + BDJTopicMargin;
        }
        
        _cellHeight += BDJTopicBottomBarH + BDJTopicMargin;
        
    }
    return _cellHeight;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id"
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"top_cmt" : @"BDJComment"
             };
}
@end
