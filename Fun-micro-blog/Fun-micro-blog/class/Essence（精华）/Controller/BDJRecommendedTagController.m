//
//  BDJRecommendedTagController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/20.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJRecommendedTagController.h"
#import "BDJRecommendedTagCell.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "BDJRecommendedModel.h"
#import "MJExtension.h"
@interface BDJRecommendedTagController ()
/** 数据*/
@property (nonatomic, strong)  NSArray *recommendedArray;
@end

@implementation BDJRecommendedTagController

static NSString * const recommendedID = @"recommendedID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJRecommendedTagCell class]) bundle:nil] forCellReuseIdentifier:recommendedID];
    //加载数据
    [self reloadData];
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BDJlobalBg;
    self.tableView.showsVerticalScrollIndicator = NO;
}
/**
 *  请求数据
 */
- (void)reloadData
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.recommendedArray = [BDJRecommendedModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.recommendedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BDJRecommendedTagCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendedID];
    
    cell.recommended = self.recommendedArray[indexPath.row];
    
    return cell;
}


@end
