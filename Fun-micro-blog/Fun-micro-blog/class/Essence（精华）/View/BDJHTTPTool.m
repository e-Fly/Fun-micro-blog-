//
//  BDJHTTPTool.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/25.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJHTTPTool.h"

@implementation BDJHTTPTool
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    self.roundedCorners = 2;
     NSString *text = [NSString stringWithFormat:@"%.0lf%%",progress * 100.0];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.progressLabel.textColor = [UIColor whiteColor];
}
@end
