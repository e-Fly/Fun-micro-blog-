//
//  BDJTopicPictureView.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/25.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJTopicPictureView.h"
#import "BDJTopic.h"
#import "UIImageView+WebCache.h"
#import "BDJHTTPTool.h"
#import "BDJShowPictureController.h"
@interface BDJTopicPictureView()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
/**
 *  gif图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/**
 *  查看大图
 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;

@property (weak, nonatomic) IBOutlet BDJHTTPTool *progerssView;


@end

@implementation BDJTopicPictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(BDJTopic *)topic
{
    _topic = topic;
    [self.progerssView setProgress:topic.progress animated:NO];
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progerssView.hidden = NO;
        topic.progress = 1.0 * receivedSize / expectedSize;
        [self.progerssView setProgress:topic.progress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progerssView.hidden = YES;
        
        // 如果是大图片, 才需要进行绘图处理
        if (topic.bigImage == NO) return;
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        
        // 将下载完的image对象绘制到图形上下文
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        // 获得图片
        self.contentImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束图形上下文
        UIGraphicsEndImageContext();

        
    }];
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    if (topic.bigImage) {
        self.seeBigBtn.hidden = NO;
        self.contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }else
    {
        self.seeBigBtn.hidden = YES;
    }
    
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加监听器
    self.contentImageView.userInteractionEnabled = YES;
    [self.contentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}
- (void)showPicture
{
   BDJShowPictureController *showVC = [[BDJShowPictureController alloc] init];
    showVC.topic = _topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVC animated:YES completion:nil];
}
@end
