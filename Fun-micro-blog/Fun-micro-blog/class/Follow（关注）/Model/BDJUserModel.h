//
//  BDJUserModel.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/20.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJUserModel : NSObject
/** 内容*/
@property (nonatomic, copy) NSString *introduction;
/** uid */
@property (nonatomic, assign) NSInteger uid;
/** 头像*/
@property (nonatomic, copy) NSString *header;
/** gender */
@property (nonatomic, assign) NSInteger gender;
/** is_vip */
@property (nonatomic, assign) BOOL is_vip;

/** 粉丝数(有多少人关注这个用户) */
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;


@end
