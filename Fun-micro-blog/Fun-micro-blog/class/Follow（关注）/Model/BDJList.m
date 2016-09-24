//
//  BDJList.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/19.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJList.h"
#import "MJExtension.h"
@implementation BDJList
- (NSMutableArray *)user
{
    if (!_user) {
        _user = [NSMutableArray array];
    }
    return _user;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}
@end
