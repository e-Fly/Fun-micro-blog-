//
//  BDJVoiceView.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/27.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDJTopic;

@interface BDJVoiceView : UIView
/** 数据模型*/
@property (nonatomic, strong) BDJTopic *topic;

+ (instancetype)voiceView;
@end
