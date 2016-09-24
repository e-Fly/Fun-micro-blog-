//
//  BDJUserCell.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/20.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJUserCell.h"
#import "UIImageView+WebCache.h"
#import "BDJUserModel.h"
@interface BDJUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *screen_name;
@property (weak, nonatomic) IBOutlet UILabel *fans_count;

@end

@implementation BDJUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setUserModel:(BDJUserModel *)userModel
{
    _userModel = userModel;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:userModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.screen_name.text = userModel.screen_name;
    self.fans_count.text = [NSString stringWithFormat:@"%zd人关注", userModel.fans_count];
}

@end
