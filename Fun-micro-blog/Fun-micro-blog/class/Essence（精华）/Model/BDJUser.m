//
//  BDJUser.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/1.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJUser.h"
#import "MJExtension.h"
@implementation BDJUser

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}
@end
