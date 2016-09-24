//
//  BDJMeCell.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/4.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJMeCell.h"
#import "UIView+BDJExtension.h"
#import "BDJConst.h"
@implementation BDJMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置cell的样式
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.backgroundView = bgImageView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + BDJTopicMargin;
    
}
@end
