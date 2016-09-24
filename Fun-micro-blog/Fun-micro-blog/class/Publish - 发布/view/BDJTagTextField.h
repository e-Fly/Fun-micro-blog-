//
//  BDJTagTextField.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/11.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDJTagTextField : UITextField
/** 删除的block*/
@property (nonatomic, copy) void(^deleteBlock)();
@end
