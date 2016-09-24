//
//  BDJRecommendedTagCell.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/20.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJRecommendedTagCell.h"
#import "UIImageView+WebCache.h"
#import "BDJRecommendedModel.h"
@interface BDJRecommendedTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *number;


@end

@implementation BDJRecommendedTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setRecommended:(BDJRecommendedModel *)recommended
{
    _recommended = recommended;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_recommended.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = _recommended.theme_name;
    NSString *subNumber = nil;
    if (_recommended.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", _recommended.sub_number];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", _recommended.sub_number / 10000.0];
    }
    self.number.text = subNumber;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= 20;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
