//
//  BDJPostWordController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/11.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJPostWordController.h"
#import "BDJPlaceholderTextView.h"
#import "BDJAddTagToolbar.h"
#import "UIView+BDJExtension.h"
@interface BDJPostWordController ()<UITextViewDelegate>
/** 文本输入控件 */
@property (nonatomic, strong) BDJPlaceholderTextView *placeholderTextView;
/** 工具条*/
@property (nonatomic, weak) BDJAddTagToolbar *tagTool;

@end

@implementation BDJPostWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTextView];
    [self setupToolbar];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.placeholderTextView becomeFirstResponder];
}
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.tagTool.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - BDJScreenH);
    }];
}

- (void)setupToolbar
{
    BDJAddTagToolbar *tagTool = [BDJAddTagToolbar tagToolBar];
    tagTool.width = self.view.width;
    tagTool.y = self.view.height - tagTool.height;
    [self.view addSubview:tagTool];
    self.tagTool = tagTool;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupTextView
{
    BDJPlaceholderTextView *placeholderTextView = [[BDJPlaceholderTextView alloc] initWithFrame:self.view.bounds];
    placeholderTextView.placehoder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    placeholderTextView.delegate = self;
    [self.view addSubview:placeholderTextView];
    self.placeholderTextView = placeholderTextView;
}
- (void)setupNav
{
    self.view.backgroundColor = BDJlobalBg;
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];
}


- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)post
{
    
}
#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
