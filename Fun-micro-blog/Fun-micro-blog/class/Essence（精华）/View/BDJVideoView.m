//
//  BDJVideoView.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/27.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJVideoView.h"
#import "BDJShowPictureController.h"
#import "UIImageView+WebCache.h"
#import "BDJTopic.h"
@interface BDJVideoView()
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end

@implementation BDJVideoView

+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)setTopic:(BDJTopic *)topic
{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    // 播放次数
    self.countLable.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    // 时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.timeLable.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}
- (void)showPicture
{
    BDJShowPictureController *showVC = [[BDJShowPictureController alloc] init];
    showVC.topic = _topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVC animated:YES completion:nil];
}

@end
