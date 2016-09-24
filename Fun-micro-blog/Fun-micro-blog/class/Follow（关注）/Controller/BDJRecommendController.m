//
//  BDJRecommendController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/18.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJRecommendController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "BDJList.h"
#import "MJExtension.h"
#import "BDJRecommendListCell.h"
#import "BDJUserModel.h"
#import "BDJUserCell.h"
#import "MJRefresh.h"
@interface BDJRecommendController ()<UITableViewDelegate,UITableViewDataSource>
/** 模型数组*/
@property (nonatomic, strong) NSArray *listArray;
/** 用户数据*/
//@property (nonatomic, strong) NSArray *userArray;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic, strong) AFHTTPSessionManager *AFmanager;
@property (nonatomic, strong) NSMutableDictionary *params;
@end

@implementation BDJRecommendController
static NSString * const BDJListId = @"list";
static NSString * const BDJUserId = @"user";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.AFmanager = [AFHTTPSessionManager manager];
    //注册
    [self.listTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJRecommendListCell class]) bundle:nil] forCellReuseIdentifier:BDJListId];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJUserCell class]) bundle:nil] forCellReuseIdentifier:BDJUserId];
    self.userTableView.rowHeight = 60;
    self.navigationItem.title = @"推荐关注";
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    [self reloadLeftList];
    //设置table滚动64
    [self SheZhiUnset];
}

- (void)reloadLeftList
{
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.AFmanager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        self.listArray = [BDJList mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.listTableView reloadData];
        [self.listTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        BDJLog(@"%@",error);
        
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        
    }];
}

//设置table滚动64
- (void)SheZhiUnset
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.listTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.listTableView.contentInset;
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
}
/**
 *  加载最新数据
 */
- (void)loadNewData
{
    BDJList *list = self.listArray[self.listTableView.indexPathForSelectedRow.row];
    list.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(list.ID);
    params[@"page"] = @(list.currentPage);
    self.params = params;
    [self.AFmanager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *userArray = [BDJUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [list.user removeAllObjects];
        [list.user addObjectsFromArray:userArray];
        list.total = [responseObject[@"total"] integerValue];
        
        if (self.params != params) return;
        
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.userTableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];

}
/**
 *  加载右侧数据
 */
- (void)loadData
{

    BDJList *list = self.listArray[self.listTableView.indexPathForSelectedRow.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(list.ID);
    params[@"page"] = @(++list.currentPage);
    self.params = params;
    [self.AFmanager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *userArray = [BDJUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [list.user addObjectsFromArray:userArray];
            
            if (self.params != params) return;
            
            [self.userTableView reloadData];
            
            [self checkFooterState];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.userTableView.mj_header endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }];

}
/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
      BDJList *list = self.listArray[self.listTableView.indexPathForSelectedRow.row];
    if (list.user.count == list.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }
}
#pragma mark -- table代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.listTableView)
        return self.listArray.count;
    BDJList *list = self.listArray[self.listTableView.indexPathForSelectedRow.row];
    self.userTableView.mj_footer.hidden = (list.user.count == 0);
    return list.user.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.listTableView) {
        BDJRecommendListCell *cell = [tableView dequeueReusableCellWithIdentifier:BDJListId];
        cell.list = self.listArray[indexPath.row];
        return cell;
    }else
    {
        BDJUserCell *cell = [tableView dequeueReusableCellWithIdentifier:BDJUserId];
       BDJList *list = self.listArray[self.listTableView.indexPathForSelectedRow.row];
        cell.userModel = list.user[indexPath.row];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableView.mj_footer endRefreshing];
    [self.userTableView.mj_header endRefreshing];
    BDJList *list = self.listArray[self.listTableView.indexPathForSelectedRow.row];
    if (list.user.count) {
        [self.userTableView reloadData];
    }else
    {
        [self.userTableView reloadData];
        [self.userTableView.mj_header beginRefreshing];
    }
}
- (void)dealloc
{
    [self.AFmanager.operationQueue cancelAllOperations];
}
@end
