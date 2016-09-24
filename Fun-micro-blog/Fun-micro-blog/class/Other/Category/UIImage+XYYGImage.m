//
//  UIImage+XYYGImage.m
//  校园易购
//
//  Created by 翟聪聪 on 16/3/26.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "UIImage+XYYGImage.h"

@implementation UIImage (XYYGImage)

+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
