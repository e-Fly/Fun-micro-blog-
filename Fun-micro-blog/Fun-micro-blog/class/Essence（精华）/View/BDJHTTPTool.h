//
//  BDJHTTPTool.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/25.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DALabeledCircularProgressView.h"
@interface BDJHTTPTool : DALabeledCircularProgressView

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
