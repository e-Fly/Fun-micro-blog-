//
//  BDJCommentHeaderView.h
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/1.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDJCommentHeaderView : UITableViewHeaderFooterView
/** 组标题*/
@property (nonatomic, copy) NSString *title;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;
@end
