//
//  BDJSetupController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/12.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJSetupController.h"
#import "SDImageCache.h"
@interface BDJSetupController ()

@end

@implementation BDJSetupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = BDJlobalBg;
    [self getsize];
}

- (void)getsize2
{
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachesPath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    NSArray *subpaths = [manager subpathsAtPath:cachesPath];
    BDJLog(@"%@",subpaths);
    
}
- (void)getsize
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachespath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:cachespath];
    NSInteger *totalsize = 0;
    for (NSString *fileName in fileEnumerator) {
        NSString *filepath = [cachespath stringByAppendingPathComponent:fileName];
        // 判断文件的类型：文件\文件夹
        NSDictionary *arras = [manager attributesOfItemAtPath:filepath error:nil];
        if ([arras[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        
        totalsize += [arras[NSFileSize] integerValue];
        
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    CGFloat size = [SDImageCache sharedImageCache].getSize / 1000.0 / 1000;
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存（已使用%.2fMB）", size];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SDImageCache sharedImageCache] clearDisk];
    [self.tableView reloadData];
}

@end
