//
//  BDJTagViewController.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/11.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDJTagViewController : UIViewController

/** 回传数据的block*/
@property (nonatomic, copy) void(^tagBlock)(NSArray *tags);

/** 所有的标签 */
@property (nonatomic, strong) NSArray *tags;
@end
