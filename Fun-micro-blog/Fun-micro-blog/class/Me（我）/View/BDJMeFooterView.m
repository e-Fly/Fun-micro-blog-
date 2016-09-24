//
//  BDJMeFooterView.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/5.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJMeFooterView.h"
#import "AFNetworking.h"
#import "BDJSquare.h"
#import "MJExtension.h"
#import "BDJSqaureButton.h"
#import "UIView+BDJExtension.h"
@implementation BDJMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //发送请求
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *sqaures = [BDJSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            // 创建方块
            [self createSquares:sqaures];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
}
- (void)createSquares:(NSArray *)sqaures
{
    //一行最多4个
    int maxcols = 4;
    
    //按钮的宽高
    CGFloat buttonW = BDJScreenW / maxcols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<sqaures.count; i++) {
        // 创建按钮
        BDJSqaureButton *button = [BDJSqaureButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.square = sqaures[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxcols;
        int row = i / maxcols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    
    NSUInteger rows = (sqaures.count + maxcols - 1) / maxcols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    self.tableView.tableFooterView = self;
    // 重绘
    [self setNeedsDisplay];
}
- (void)buttonClick:(UIButton *)button
{
    
}
@end
