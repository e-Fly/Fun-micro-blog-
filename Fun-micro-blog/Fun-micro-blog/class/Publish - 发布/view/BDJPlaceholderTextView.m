//
//  BDJPlaceholderTextView.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/11.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJPlaceholderTextView.h"
#import "UIView+BDJExtension.h"
@interface BDJPlaceholderTextView()

/** 占位label*/
@property (nonatomic, weak) UILabel *placehoderLabel;


@end


@implementation BDJPlaceholderTextView

- (UILabel *)placehoderLabel
{
    if (_placehoderLabel == nil) {
        //添加一个lable充当占位符
        UILabel *placehoderLabel = [[UILabel alloc] init];
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.x = 4;
        placehoderLabel.y = 7;
        
        [self addSubview:placehoderLabel];
        _placehoderLabel = placehoderLabel;
    }
    return _placehoderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //总可以拖拽
        self.alwaysBounceVertical = YES;
        //设置默认文字
        self.font = [UIFont systemFontOfSize:15];
        

        self.placehoderColor = [UIColor grayColor];
        //监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}
- (void)textDidChange
{
    self.placehoderLabel.hidden = self.hasText;
}
- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    self.placehoderLabel.text = placehoder;
    [self updataPlacehoderLableSize];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  更新占位文字的尺寸
 */
- (void)updataPlacehoderLableSize
{
    CGSize maxsize = CGSizeMake(self.width - 2 * self.placehoderLabel.x, MAXFLOAT);
    self.placehoderLabel.size = [self.placehoder boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
    
}
- (void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    self.placehoderLabel.textColor = placehoderColor;
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placehoderLabel.font = font;
    [self updataPlacehoderLableSize];
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}
@end
