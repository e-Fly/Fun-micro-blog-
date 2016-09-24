//
//  UIBarButtonItem+BDJLeftBar.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/18.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "UIBarButtonItem+BDJLeftBar.h"

@implementation UIBarButtonItem (BDJLeftBar)

+ (instancetype)itemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName tagate:(id)tagate action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
    [button addTarget:tagate action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];
}


@end
