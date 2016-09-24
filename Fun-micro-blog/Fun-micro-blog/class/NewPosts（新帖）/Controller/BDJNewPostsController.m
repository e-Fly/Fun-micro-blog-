//
//  BDJNewPostsController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/18.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJNewPostsController.h"
#import "UIBarButtonItem+BDJLeftBar.h"
@interface BDJNewPostsController ()

@end

@implementation BDJNewPostsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" selectedImageName:@"MainTagSubIconClick" tagate:self action:@selector(xintie)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.view.backgroundColor = BDJlobalBg;
}

- (void)xintie
{
    BDJLog(@"%s",__func__);
}
@end
