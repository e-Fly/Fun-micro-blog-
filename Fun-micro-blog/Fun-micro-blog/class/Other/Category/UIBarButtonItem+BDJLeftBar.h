//
//  UIBarButtonItem+BDJLeftBar.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/18.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BDJLeftBar)

+ (instancetype)itemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName tagate:(id)tagate action:(SEL)action;

@end
