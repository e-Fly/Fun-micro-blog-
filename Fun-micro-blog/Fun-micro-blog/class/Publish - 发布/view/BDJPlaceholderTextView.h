//
//  BDJPlaceholderTextView.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/11.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDJPlaceholderTextView : UITextView
/** 占位文字*/
@property (nonatomic, copy) NSString *placehoder;

/** 占位文字颜色*/
@property (nonatomic, strong) UIColor *placehoderColor;
@end
