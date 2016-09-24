//
//  BDJTagTextField.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/11.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJTagTextField.h"
#import "UIView+BDJExtension.h"
@implementation BDJTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        // 设置了占位文字内容以后, 才能设置占位文字的颜色
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self sizeToFit];
        self.height = 25;

        
    }
    return self;
}

- (void)deleteBackward
{
    if (self.deleteBlock) {
        self.deleteBlock();
    }
    [super deleteBackward];
}
@end
