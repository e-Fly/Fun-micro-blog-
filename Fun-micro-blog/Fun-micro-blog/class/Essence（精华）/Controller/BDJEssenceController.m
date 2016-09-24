//
//  BDJEssenceController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/18.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//
#define tagCount 10
#import "BDJEssenceController.h"
#import "BDJRecommendedTagController.h"
#import "BDJTopicController.h"
#import "UIView+BDJExtension.h"
#import "UIBarButtonItem+BDJLeftBar.h"
@interface BDJEssenceController ()<UIScrollViewDelegate>
/** 底部view*/
@property (nonatomic, weak) UIView *bottomView;
/** 标题按钮*/
@property (nonatomic, weak) UIButton *titleBtn;
/** 顶部标题*/
@property (nonatomic, weak) UIView *titleView;
/** 内容*/
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation BDJEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self addChildVC];
    //设置背景
    self.view.backgroundColor = BDJlobalBg;
    //设置导航条
    [self setUpNav];
    
    //添加内容视图
    [self setUpContentView];
    //添加头标题
    [self setUpTitleView];
    
    
    
}

- (void)addChildVC
{
 
    
    BDJTopicController *pictureVC = [[BDJTopicController alloc] init];
    pictureVC.title = @"图片";
    pictureVC.type = BDJTopicTypePicture;
    [self addChildViewController:pictureVC];

    
    BDJTopicController * allVC = [[BDJTopicController alloc] init];
    allVC.title = @"全部";
    allVC.type = BDJTopicTypeAll;
    [self addChildViewController:allVC];
    
    
    BDJTopicController *videoVC = [[BDJTopicController alloc] init];
    videoVC.title = @"视频";
    videoVC.type = BDJTopicTypeVideo;
    [self addChildViewController:videoVC];
    
    
    BDJTopicController *voiceVC = [[BDJTopicController alloc] init];
    voiceVC.title = @"声音";
    voiceVC.type = BDJTopicTypeVoice;
    [self addChildViewController:voiceVC];
    
    
    
    BDJTopicController *wordVC = [[BDJTopicController alloc] init];
    wordVC.title = @"段子";
    wordVC.type = BDJTopicTypeWord;
    [self addChildViewController:wordVC];
    
}

- (void)recommendedTag
{
    [self.navigationController pushViewController:[[BDJRecommendedTagController alloc] init] animated:YES];
}
- (void)setUpNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" selectedImageName:@"MainTagSubIconClick" tagate:self action:@selector(recommendedTag)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}
- (void)setUpTitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titleView.y = 44;
    titleView.height = 35;
    titleView.width = self.view.width;
    _titleView = titleView;
    // 内部的子标签
    CGFloat width = self.view.width/self.childViewControllers.count;
    CGFloat height = titleView.height;
    for (int i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.width = width;
        button.height = height;
        button.x = i * width;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = i + tagCount;
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        if (i == 0) {
            UIView *bottomView = [[UIView alloc] init];
            bottomView.height = 2;
            bottomView.y = titleView.height - bottomView.height;
            bottomView.width = button.titleLabel.width;
            bottomView.backgroundColor = [UIColor redColor];
            _bottomView = bottomView;
            [titleView addSubview:bottomView];
            [button layoutIfNeeded];
            [self titleClick:button];
            [self scrollViewDidEndScrollingAnimation:self.contentView];
        }
    }
    [self.view addSubview:titleView];
}

- (void)titleClick:(UIButton *)button
{
    self.titleBtn.enabled = YES;
    button.enabled = NO;
    self.titleBtn = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.width = button.titleLabel.width;
        self.bottomView.centerX = button.centerX;
    }];
    CGPoint offset = self.contentView.contentOffset;
    offset.x = (button.tag - tagCount) * self.view.width;
    [self.contentView setContentOffset:offset animated:YES];
}
- (void)setUpContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/self.view.width;
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = index * self.view.width;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    CGFloat bottom = self.tabBarController.tabBar.height;
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    vc.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(top, 0, bottom, 0);
    [scrollView addSubview:vc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:[self.titleView viewWithTag:index + tagCount]];
}

@end
