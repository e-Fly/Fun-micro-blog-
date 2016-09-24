//
//  UIView+BDJExtension.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/21.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BDJExtension)
/** 大小 */
@property (nonatomic, assign) CGSize size;
/** 高度 */
@property (nonatomic, assign) CGFloat height;
/** 宽度 */
@property (nonatomic, assign) CGFloat width;

/** X */
@property (nonatomic, assign) CGFloat x;
/** Y */
@property (nonatomic, assign) CGFloat y;

/** centerX */
@property (nonatomic, assign) CGFloat centerX;

/** centerY */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  是不是显示在当前主窗口上
 */
- (BOOL)isShowingOnKeyWindow;

@end
