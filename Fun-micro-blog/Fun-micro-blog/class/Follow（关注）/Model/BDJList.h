//
//  BDJList.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/19.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJList : NSObject

/** id */
@property (nonatomic, assign) NSInteger ID;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名称*/
@property (nonatomic, copy) NSString *name;

/** users数据*/
@property (nonatomic, strong) NSMutableArray *user;
/** 当前页数 */
@property (nonatomic, assign) NSInteger currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
@end
