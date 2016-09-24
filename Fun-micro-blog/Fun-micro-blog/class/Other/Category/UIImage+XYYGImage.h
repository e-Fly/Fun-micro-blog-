//
//  UIImage+XYYGImage.h
//  校园易购
//
//  Created by 翟聪聪 on 16/3/26.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XYYGImage)

/**
 *  加载最原始的图片
 *
 *  @param imageName 图片名称
 *
 *  @return <#return value description#>
 */
+ (instancetype) imageWithOriginalName:(NSString *)imageName;
@end
