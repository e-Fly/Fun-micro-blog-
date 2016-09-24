//
//  BDJLoginTool.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/12.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJLoginTool : NSObject
/**
 *  检测是否登录
 *
 *  @return 返回userID
 */
+ (NSString *)getUserId;
@end
