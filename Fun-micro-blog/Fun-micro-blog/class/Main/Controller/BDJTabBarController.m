//
//  BDJTabBarController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/18.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJTabBarController.h"
#import "BDJNavController.h"
#import "BDJEssenceController.h"
#import "BDJFriendTrendsController.h"
#import "BDJNewPostsController.h"
#import "BDJMeController.h"
#import "UIImage+XYYGImage.h"
#import "BDJTabBar.h"

@interface BDJTabBarController ()

@end

@implementation BDJTabBarController

+ (void)initialize
{
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    att[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:att forState:UIControlStateNormal];
    
    NSMutableDictionary *selectAtt = [NSMutableDictionary dictionary];
    selectAtt[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectAtt forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //修改父控件的tabBar
 
    
    [self setOneViewControllerWithController:[[BDJEssenceController alloc] init] imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon" title:@"精华"];
    
    [self setOneViewControllerWithController:[[BDJNewPostsController alloc] init] imageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon" title:@"新帖"];
    
    [self setOneViewControllerWithController:[[BDJFriendTrendsController alloc] init] imageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon" title:@"关注"];
    
    [self setOneViewControllerWithController:[[BDJMeController alloc] initWithStyle:UITableViewStyleGrouped] imageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon" title:@"我"];
    [self setValue:[[BDJTabBar alloc] init] forKey:@"tabBar"];
}

- (void)setOneViewControllerWithController:(UIViewController *)viewController imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title
{
    BDJNavController *nav = [[BDJNavController alloc] initWithRootViewController:viewController];
    nav.tabBarItem.image = [UIImage imageWithOriginalName:imageName];
    viewController.tabBarItem.title = title;
    viewController.navigationItem.title = title;
    nav.tabBarItem.selectedImage = [UIImage imageWithOriginalName:selectedImageName];
    nav.tabBarItem.title = title;
    [self addChildViewController:nav];
}




@end
