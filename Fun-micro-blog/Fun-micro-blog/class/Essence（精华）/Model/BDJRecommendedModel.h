//
//  BDJRecommendedModel.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/20.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJRecommendedModel : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
@end
