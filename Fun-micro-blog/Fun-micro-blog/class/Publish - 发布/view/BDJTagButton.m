//
//  BDJTagButton.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/11.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJTagButton.h"
#import "UIView+BDJExtension.h"
@implementation BDJTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = BDJColor(74, 139, 209);
    }
    return self;
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3 * tagMargin;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = tagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + tagMargin;
}
@end
