//
//  BDJFriendTrendsController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/18.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJFriendTrendsController.h"
#import "BDJRecommendController.h"
#import "BDJLoginController.h"
#import "UIBarButtonItem+BDJLeftBar.h"
@interface BDJFriendTrendsController ()

@end

@implementation BDJFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" selectedImageName:@"friendsRecommentIcon-click" tagate:self action:@selector(friendsRecommentIconClick)];
    self.view.backgroundColor = BDJlobalBg;
}

- (void)friendsRecommentIconClick
{
    [self.navigationController pushViewController:[[BDJRecommendController alloc] init] animated:YES];
}
- (IBAction)loginAndRegisterClick {
    [self presentViewController:[[BDJLoginController alloc] init] animated:YES completion:nil];
}

@end
