//
//  BDJTopicController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/23.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//



#import "BDJTopicController.h"
#import "AFNetworking.h"
#import "BDJTopicCell.h"
#import "MJExtension.h"
#import "BDJTopic.h"
#import "MJRefresh.h"
#import "BDJTopicCommentController.h"
#import "BDJNewPostsController.h"
#import "UIView+BDJExtension.h"
@interface BDJTopicController ()
/** 模型数组*/
@property (nonatomic, strong) NSMutableArray *topicArry;
/** maxtime*/
@property (nonatomic, copy) NSString *maxtime;
/** 当前页数 */
@property (nonatomic, assign) NSInteger page;
/** 请求字典*/
@property (nonatomic, strong) NSDictionary *params;
/** 上次选中的索引 */
@property (nonatomic, assign) NSInteger lastSelectIndex;

@end

@implementation BDJTopicController

- (NSMutableArray *)topicArry
{
    if (_topicArry == nil) {
        _topicArry = [NSMutableArray array];
    }
    return _topicArry;
}

static NSString * const topicID = @"TopicCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tableView
    [self setUpTableView];
    
    //监听tabBar点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelect) name:BDJTabBarDidClickNotification object:nil];
    
}
/**
 *  设置tableView
 */
- (void)setUpTableView
{
    //添加头部刷新空间
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //添加上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJTopicCell class]) bundle:nil] forCellReuseIdentifier:topicID];
    
   
}

- (void)tabBarSelect
{
//    选中的不是当前的控制器就返回
    //如果连续点重俩次
    if (self.lastSelectIndex == self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
    }
    self.lastSelectIndex = self.tabBarController.selectedIndex;
}

- (NSString *)a
{
    return [self.parentViewController isKindOfClass:[BDJNewPostsController class]] ? @"newlist" : @"list";
}
//加载先数据
- (void)loadNewData
{
    self.page = 0;
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topicArry = [BDJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}
/**
 *  加载更多数据
 */
- (void)loadMoreData
{
    [self.tableView.mj_header endRefreshing];
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    self.page++;
    params[@"page"] = @(self.page);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.topicArry addObjectsFromArray:[BDJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
  
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        self.page--;
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.mj_footer.hidden = !self.topicArry.count;
    return self.topicArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDJTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicID];
    cell.topic = self.topicArry[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDJTopic *topic = self.topicArry[indexPath.row];
    return topic.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDJTopicCommentController *cmt = [[BDJTopicCommentController alloc] init];
    BDJTopic *topic = self.topicArry[indexPath.row];
    cmt.topic = topic;
    [self.navigationController pushViewController:cmt animated:YES];
}
@end
