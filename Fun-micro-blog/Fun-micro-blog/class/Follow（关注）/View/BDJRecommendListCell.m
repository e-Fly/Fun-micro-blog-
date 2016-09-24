//
//  BDJRecommendListCell.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/19.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJRecommendListCell.h"
#import "BDJList.h"

@interface BDJRecommendListCell()
@property (weak, nonatomic) IBOutlet UIView *selectedView;

@end


@implementation BDJRecommendListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = BDJColor(244, 244, 244);
    self.selectedView.hidden = YES;
}
- (void)setList:(BDJList *)list
{
    _list = list;
    self.textLabel.text = list.name;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.textLabel.frame;
    frame.origin.y = 2;
    frame.size.height = self.contentView.frame.size.height - 2 * frame.origin.y;
    self.textLabel.frame = frame;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedView.hidden = !selected;
}

@end
