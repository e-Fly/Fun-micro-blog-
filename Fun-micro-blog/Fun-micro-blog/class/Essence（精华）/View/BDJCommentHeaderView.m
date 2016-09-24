//
//  BDJCommentHeaderView.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/1.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJCommentHeaderView.h"
#import "UIView+BDJExtension.h"
#import "BDJConst.h"

@interface BDJCommentHeaderView ()
/** 文字标签 */
@property (nonatomic, weak) UILabel *label;

@end


@implementation BDJCommentHeaderView


+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    BDJCommentHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (headView == nil) { // 缓存池中没有, 自己创建
        headView = [[BDJCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headView;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = BDJlobalBg;
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = BDJColor(67, 67, 67);
        label.width = 200;
        label.x = BDJTopicMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text = title;
}
@end
