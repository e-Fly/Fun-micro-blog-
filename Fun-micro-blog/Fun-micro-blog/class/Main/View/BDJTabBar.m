//
//  BDJTabBar.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/18.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJTabBar.h"
#import "UIImage+XYYGImage.h"
#import "BDJPublishController.h"
#import "UIView+BDJExtension.h"
@interface BDJTabBar()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation BDJTabBar

- (UIButton *)publishButton
{
    if (_publishButton == nil) {
        UIButton *publishButton = [[UIButton alloc] init];
        [publishButton  setImage:[UIImage imageWithOriginalName:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton  setImage:[UIImage imageWithOriginalName:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton sizeToFit];
        publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        [publishButton addTarget:self action:@selector(pressentPublishVC) forControlEvents:UIControlEventTouchUpInside];
        _publishButton = publishButton;
        [self addSubview:publishButton];
    }
    return _publishButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
     if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageWithOriginalName:@"tabbar-light"]];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
        
        if (added == NO) {
            // 监听按钮点击
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    added = YES;

   
}
- (void)pressentPublishVC
{
    BDJPublishController *publish = [[BDJPublishController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:YES completion:nil];
}
- (void)buttonClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BDJTabBarDidClickNotification object:nil userInfo:nil];
}
@end
