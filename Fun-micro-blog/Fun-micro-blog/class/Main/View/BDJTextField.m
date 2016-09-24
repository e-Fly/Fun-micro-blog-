//
//  BDJTextField.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/22.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJTextField.h"
#import <objc/runtime.h>
@implementation BDJTextField
static NSString * const BDJPlacerholderColorKeyPath = @"_placeholderLabel.textColor";
+ (void)initialize
{
    [self getIvars];
}

+ (void)getProperties
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出属性
        objc_property_t property = properties[i];
        
        // 打印属性名字
        BDJLog(@"%s   <---->   %s", property_getName(property), property_getAttributes(property));
    }
    
    free(properties);
}

+ (void)getIvars
{
    unsigned int count = 0;
    
    // 拷贝出所有的成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        //        Ivar ivar = *(ivars + i);
        Ivar ivar = ivars[i];
        
        // 打印成员变量名字
        BDJLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    
    // 释放
    free(ivars);
}
- (void)awakeFromNib
{
    self.textColor = [UIColor whiteColor];
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

@end
