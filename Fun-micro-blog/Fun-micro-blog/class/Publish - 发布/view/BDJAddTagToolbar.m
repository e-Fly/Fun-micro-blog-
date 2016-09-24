//
//  BDJAddTagToolbar.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/11.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJAddTagToolbar.h"
#import "UIView+BDJExtension.h"
#import "BDJConst.h"
#import "BDJTagViewController.h"
@interface  BDJAddTagToolbar()
@property (weak, nonatomic) IBOutlet UIView *topView;
/** lables数组*/
@property (nonatomic, strong) NSMutableArray *tagLabels;
/** 添加按钮*/
@property (nonatomic, weak) UIButton *addBtn;

@end

@implementation BDJAddTagToolbar

- (NSMutableArray *)tagLabels
{
    if (_tagLabels == nil) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

+ (instancetype)tagToolBar
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addBtn.size = addBtn.currentImage.size;
    addBtn.x = tagMargin;
    [self.topView addSubview:addBtn];
    _addBtn = addBtn;
    [self creatLable:@[@"吐槽",@"糗事"]];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        if (i == 0) { // 最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + tagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) { // 按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + tagMargin;
            }
        }
        
    }
    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + tagMargin;
    
    // 更新textField的frame
    if (self.topView.width - leftWidth >= self.addBtn.width) {
        self.addBtn.y = lastTagLabel.y;
        self.addBtn.x = leftWidth;
    } else {
        self.addBtn.x = 0;
        self.addBtn.y = CGRectGetMaxY(lastTagLabel.frame) + tagMargin;
    }
    //设置topview的高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addBtn.frame) + 35;
    self.y -= self.height - oldH;
}
- (void)addButtonClick
{
    BDJTagViewController *tagVC = [[BDJTagViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    [tagVC setTagBlock:^(NSArray *tags) {
        [weakSelf creatLable:tags];
    }];
    tagVC.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController*)root.presentedViewController;
    [nav pushViewController:tagVC animated:YES];
}
- (void)creatLable:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = BDJColor(74, 139, 209);
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = [UIFont systemFontOfSize:14];
        // 应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.width += 2 * tagMargin;
        tagLabel.height = 25;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
    }
    [self setNeedsLayout];
}
@end
