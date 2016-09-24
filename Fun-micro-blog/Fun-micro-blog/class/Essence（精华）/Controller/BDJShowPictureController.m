//
//  BDJShowPictureController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/25.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJShowPictureController.h"
#import "BDJTopic.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "BDJHTTPTool.h"
#import "UIView+BDJExtension.h"
@interface BDJShowPictureController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet BDJHTTPTool *progressView;
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation BDJShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = self.topic.height/self.topic.width;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    _imageView = imageView;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    CGFloat width = BDJBounds.size.width;
    CGFloat height = width * self.topic.height/self.topic.width;
    if (height>BDJBounds.size.height) {
        //滚动查看
        imageView.frame = CGRectMake(0, 0, width, height);
        self.scrollView.contentSize = CGSizeMake(0, height);
    }else
    {
        imageView.size = CGSizeMake(width, height);
        imageView.centerY = BDJBounds.size.height * 0.5;
    }
    [self.progressView setProgress:self.topic.progress animated:NO];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize/expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
  
        self.progressView.hidden = YES;
    }];
}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)seave {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片没下载完"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
