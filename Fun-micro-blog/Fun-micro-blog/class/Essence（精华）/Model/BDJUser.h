//
//  BDJUser.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/1.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJUser : NSObject
/** id*/
@property (nonatomic, copy) NSString *ID;
/** vip */
@property (nonatomic, assign) NSInteger is_vip;
/** 头像*/
@property (nonatomic, copy) NSString *profile_image;
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
@end
