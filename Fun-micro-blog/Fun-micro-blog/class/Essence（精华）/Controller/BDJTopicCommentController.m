//
//  BDJTopicCommentController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/1.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJTopicCommentController.h"
#import "UIBarButtonItem+BDJLeftBar.h"
#import "BDJTopicCell.h"
#import "UIView+BDJExtension.h"
#import "BDJTopic.h"
#import "BDJConst.h"
#import "BDJComment.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "BDJCommentCell.h"
#import "BDJCommentHeaderView.h"

@interface BDJTopicCommentController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 保存热门帖子*/
@property (nonatomic, strong) NSArray *hotComment;
/** 保存最新帖子*/
@property (nonatomic, strong) NSMutableArray *NewComment;

/** 保存帖子的top_cmt */
@property (nonatomic, strong) BDJComment *saved_top_cmt;
/** 页数 */
@property (nonatomic, assign) NSInteger page;


/** 管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation BDJTopicCommentController
static NSString * const BDJCommentId = @"comment";
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupKeyboard];
    [self setupHeadView];
    [self setupTableView];
}
- (void)setupHeadView
{
    if (self.topic.top_cmt) {
        self.saved_top_cmt = [self.topic.top_cmt firstObject];
        self.topic.top_cmt = nil;
        self.topic.cellHeight = 0;
    }
    UIView *headView = [[UIView alloc] init];
    headView.height = self.topic.cellHeight + BDJTopicMargin - self.topic.CommentHeight;
    BDJTopicCell *headcell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BDJTopicCell class]) owner:nil options:nil] firstObject];
    headcell.topic = self.topic;
    headcell.size = CGSizeMake(BDJScreenW, self.topic.cellHeight - self.topic.CommentHeight);
    [headView addSubview:headcell];
    self.tableView.tableHeaderView = headView;
    // 背景色
    self.tableView.backgroundColor = BDJlobalBg;
}
- (void)setupKeyboard
{
    //标题
    self.title = @"评论";
    //分组样式
    self.tableView.separatorStyle = UITableViewStyleGrouped;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    右边导航按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"comment_nav_item_share_icon" selectedImageName:@"comment_nav_item_share_icon_click" tagate:self action:nil];
//    监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}
- (void)setupTableView
{
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJCommentCell class]) bundle:nil] forCellReuseIdentifier:BDJCommentId];
    //头部刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
    //底部刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
    // cell的高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, BDJTopicMargin, 0);
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/**
 *  加载更多数据
 */
- (void)loadMoreComments
{
    //取消以前的
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 页码
    NSInteger page = self.page + 1;
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    BDJComment *cmt = [self.NewComment lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]])
        {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        [self.NewComment addObjectsFromArray:[BDJComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        [self.tableView reloadData];
        // 页码
        self.page = page;
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.NewComment.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }else {
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
/**
 *  加载最新数据
 */
- (void)loadNewComment
{
    //取消以前的
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";

    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if (![responseObject isKindOfClass:[NSDictionary class]])
         {
             [self.tableView.mj_header endRefreshing];
             return;
         }
        self.NewComment = [BDJComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.hotComment = [BDJComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        [self.tableView reloadData];
        // 页码
        self.page = 1;
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.NewComment.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottomSapce.constant = BDJScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 恢复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = @[self.saved_top_cmt];
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
}
#pragma mark - UITableViewDataSource and UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.NewComment.count == 0);
    if (section == 0) {
        return self.hotComment.count ? self.hotComment.count : self.NewComment.count;
    }
    
    return self.NewComment.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComment.count) {
        return 2;
    }else if (self.NewComment.count)
    {
        return 1;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BDJCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:BDJCommentId];
    if (indexPath.section == 0) {
        cell.comment = self.hotComment.count ? self.hotComment[indexPath.row] : self.NewComment[indexPath.row];
    }else
    {
        cell.comment = self.NewComment[indexPath.row];
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BDJCommentHeaderView *header = [BDJCommentHeaderView headViewWithTableView:tableView];
    if (section == 0) {
        header.title = self.hotComment.count ? @"最热评论" : @"最新评论";
    }else
    {
        header.title = @"最新评论";
    }
    
    return header;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else
    {
        BDJCommentCell *cell = (BDJCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        //UIMenuController必须成为第一响应者
        [cell becomeFirstResponder];
        
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[ding,replay,report];
        
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        
        [menu setTargetRect:rect inView:cell];
        
        [menu setMenuVisible:YES animated:YES];
    }
    
    
    
}
- (void)ding:(UIMenuController *)menu
{
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    BDJLog(@"%s,%@",__func__,[self commentWitchIndexPath:indexPath].content);
    
}
- (void)replay:(UIMenuController *)menu
{
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    BDJLog(@"%s,%@",__func__,[self commentWitchIndexPath:indexPath].content);
}
- (void)report:(UIMenuController *)menu
{
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    BDJLog(@"%s,%@",__func__,[self commentWitchIndexPath:indexPath].content);
}
- (BDJComment *)commentWitchIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.hotComment.count ? self.hotComment[indexPath.row] : self.NewComment[indexPath.row];
    }else
    {
        return self.NewComment[indexPath.row];
    }

}
@end
