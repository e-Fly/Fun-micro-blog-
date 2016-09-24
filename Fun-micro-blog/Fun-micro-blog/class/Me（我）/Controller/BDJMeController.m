//
//  BDJMeController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/18.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJMeController.h"
#import "UIBarButtonItem+BDJLeftBar.h"
#import "BDJConst.h"
#import "BDJMeCell.h"
#import "BDJMeFooterView.h"
#import "UIView+BDJExtension.h"
#import "BDJSetupController.h"
@interface BDJMeController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BDJMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setupTableView];
    [self setupFooterView];
}
- (void)setupTableView
{
    self.tableView.backgroundColor = BDJlobalBg;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = BDJTopicMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(BDJTopicMargin - 35, 0, 0, 0);

    
}
- (void)setupFooterView
{

    BDJMeFooterView *footer = [[BDJMeFooterView alloc] init];
    footer.tableView = self.tableView;
    self.tableView.tableFooterView = footer;
    
}

- (void)setUpNav
{
    self.navigationItem.title = @"我的";
    UIBarButtonItem *setUpItem = [UIBarButtonItem itemWithImageName:@"mine-setting-icon" selectedImageName:@"mine-setting-icon-click" tagate:self action:@selector(me)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImageName:@"mine-moon-icon" selectedImageName:@"mine-moon-icon-click" tagate:self action:@selector(moon)];
    self.navigationItem.rightBarButtonItems = @[setUpItem,moonItem];
    self.view.backgroundColor = BDJlobalBg;
}

- (void)me
{
    BDJSetupController *setupVC = [[BDJSetupController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:setupVC animated:YES];
}
- (void)moon
{
    BDJLog(@"%s",__func__);
}
#pragma  mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Me";
    BDJMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BDJMeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
        
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}
@end
