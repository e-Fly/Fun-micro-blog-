//
//  BDJLoginController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/5/21.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJLoginController.h"
#import "UIView+BDJExtension.h"
@interface BDJLoginController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation BDJLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (IBAction)showLoginOrRegister:(UIButton *)sender {
    // 退出键盘
    [self.view endEditing:YES];
    if (self.loginViewLeftMargin.constant == 0) {

        self.loginViewLeftMargin.constant = - self.view.width;
        sender.selected = NO;
    }else
    {
        self.loginViewLeftMargin.constant = 0;
         sender.selected = YES;
    }
    sender.selected = !sender.selected;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}



@end
