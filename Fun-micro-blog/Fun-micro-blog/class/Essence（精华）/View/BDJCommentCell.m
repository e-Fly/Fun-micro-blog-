//
//  BDJCommentCell.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/1.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJCommentCell.h"
#import "UIImageView+WebCache.h"
#import "BDJComment.h"
#import "BDJUser.h"
#import "BDJConst.h"
@interface BDJCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation BDJCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}



- (void)setComment:(BDJComment *)comment
{
    _comment = comment;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexImageView.image = [comment.user.sex isEqualToString:BDJUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLable.text = comment.content;
    self.userNameLable.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }

}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = BDJTopicMargin;
    frame.size.width -= 2 * BDJTopicMargin;
     [super setFrame:frame];
}
#pragma mark - UIMenuController代理
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}
@end
