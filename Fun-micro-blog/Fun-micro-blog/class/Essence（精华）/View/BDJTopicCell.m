//
//  BDJTopicCell.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/23.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJTopicCell.h"
#import "BDJTopic.h"
#import "UIImageView+WebCache.h"
#import "BDJTopicPictureView.h"
#import "BDJVoiceView.h"
#import "BDJVideoView.h"
#import "BDJComment.h"
#import "BDJUser.h"
@interface BDJTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *time;

/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
@property (weak, nonatomic) IBOutlet UILabel *text_lable;

/** 自定义的imageView*/
@property (nonatomic, weak) BDJTopicPictureView *pictureView;
/** 自定义的声音View*/
@property (nonatomic, weak) BDJVoiceView *voiceView;
/** 自定义的视频View*/
@property (nonatomic, weak) BDJVideoView *videoView;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

@end

@implementation BDJTopicCell

- (BDJTopicPictureView *)pictureView
{
    if (_pictureView == nil) {
        BDJTopicPictureView *pictureView = [BDJTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
- (BDJVoiceView *)voiceView
{
    if (_voiceView == nil) {
        BDJVoiceView *voiceView = [BDJVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
//BDJVideoView *videoView
- (BDJVideoView *)videoView
{
    if (_videoView == nil) {
        BDJVideoView *videoView = [BDJVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}
- (void)setTopic:(BDJTopic *)topic
{
    _topic = topic;
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置头像
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nickName.text = topic.name;
    self.text_lable.text = topic.text;
    self.time.text = topic.create_time;
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    //根据类型判断加什么view
    if (topic.type == BDJTopicTypePicture)
    {
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.frame = topic.pictureF;
        self.pictureView.topic = topic;
    }else if(topic.type == BDJTopicTypeVoice)
    {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.frame = topic.voiceF;
        self.voiceView.topic = topic;
    }else if(topic.type == BDJTopicTypeVideo)
    {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        
        self.videoView.frame = topic.videoF;
        self.videoView.topic = topic;
    }else
    {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    //处理热门评论的view
    BDJComment *cmt = [topic.top_cmt firstObject];
    if (cmt) {
        self.commentView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
    }else
    {
        self.commentView.hidden = YES;
    }
}

/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        [button setTitle:[NSString stringWithFormat:@"%0.1f万",count / 10000.0] forState:UIControlStateNormal];
    }else if (count > 0)
    {
        [button setTitle:[NSString stringWithFormat:@"%ld",(long)count] forState:UIControlStateNormal];
    }else
    {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}
- (IBAction)more:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存",@"举报", nil];
    [sheet showInView:self.window];
}

- (void)setFrame:(CGRect)frame
{
    
    frame.origin.x = BDJTopicMargin;
    frame.size.width -= 2 * BDJTopicMargin;
    frame.size.height = self.topic.cellHeight - BDJTopicMargin;
    frame.origin.y += BDJTopicMargin;
    
    [super setFrame:frame];

}

@end
