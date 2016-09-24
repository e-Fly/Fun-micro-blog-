//
//  BDJTopWindow.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/1.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJTopWindow.h"
#import "UIView+BDJExtension.h"
@implementation BDJTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.rootViewController = [[UIViewController alloc] init];
    window_.backgroundColor = [UIColor clearColor];
    window_.frame = CGRectMake(0, 0, BDJScreenW, 20);
    window_.windowLevel = UIWindowLevelStatusBar;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}
+ (void)show
{
    window_.hidden = NO;
}
/**
 * 监听窗口点击
 */
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}
+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}


@end
