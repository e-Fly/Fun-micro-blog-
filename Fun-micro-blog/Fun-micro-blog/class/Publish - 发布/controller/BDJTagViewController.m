//
//  BDJTagViewController.m
//  百思不得姐
//
//  Created by 翟聪聪 on 16/6/11.
//  Copyright © 2016年 翟聪聪公司名称. All rights reserved.
//

#import "BDJTagViewController.h"
#import "UIView+BDJExtension.h"
#import "BDJConst.h"
#import "BDJTagButton.h"
#import "BDJTagTextField.h"
#import "SVProgressHUD.h"
@interface BDJTagViewController ()<UITextFieldDelegate>
/** 添加试图的view*/
@property (nonatomic, weak) UIView *contentView;
/** textFiel*/
@property (nonatomic, weak) BDJTagTextField *textField;
/** 标签按钮*/
@property (nonatomic, weak) UIButton *addBtn;

/** 标签数组*/
@property (nonatomic, strong) NSMutableArray *tagArray;
@end

@implementation BDJTagViewController

- (NSMutableArray *)tagArray
{
    if (_tagArray == nil) {
        _tagArray = [NSMutableArray array];
    }
    return _tagArray;
}
- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.width = self.contentView.width;
        addBtn.height = 35;
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        addBtn.contentEdgeInsets = UIEdgeInsetsMake(0, tagMargin, 0, tagMargin);
        addBtn.backgroundColor = BDJColor(74, 139, 209);
        //让按钮的文字左对齐
        addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:addBtn];
        _addBtn = addBtn;
    }
    return _addBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTagView];
    [self addContentView];
    [self setupTextFiled];
    [self setupTags];
}

- (void)setupTags
{
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self addButtonClick];
    }
}

- (void)setupTextFiled
{
    
    BDJTagTextField *textField = [[BDJTagTextField alloc] init];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    __weak typeof(self)  weakSelf = self;
    textField.deleteBlock = ^(){
        if (weakSelf.textField.hasText) return;
        [weakSelf tagButtonClick:[self.tagArray lastObject]];
    };
    [textField becomeFirstResponder];
    textField.delegate = self;
    [self.contentView addSubview:textField];
    self.textField = textField;
}
-(void)addContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = tagMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.y = 64 + tagMargin;
    contentView.height = BDJScreenH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}
-(void)setupTagView
{
    self.title = @"添加标签";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
}

- (void)done
{
    NSMutableArray *tags = [NSMutableArray array];
    for (BDJTagButton *tagBtn in self.tagArray) {
        [tags addObject:tagBtn.currentTitle];
    }
    if (self.tagBlock) {
        self.tagBlock(tags);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textDidChange
{
    if (self.textField.hasText) {
        self.addBtn.hidden = NO;
        self.addBtn.y = CGRectGetMaxY(self.textField.frame) + tagMargin;
        [self.addBtn setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        //取出最后一个字符
        NSString *lastChar = [self.textField.text substringFromIndex:self.textField.text.length - 1];
        if (([lastChar isEqualToString:@","] || [lastChar isEqualToString:@"，"]) && self.textField.text.length > 1) {
            self.textField.text = [self.textField.text substringToIndex:self.textField.text.length - 1];
            [self addButtonClick];
        }
        
    }else
    {
        self.addBtn.hidden = YES;
    }
}
- (void)addButtonClick
{
    if (self.tagArray.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        return;
    }
    BDJTagButton *tagButton = [BDJTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagArray addObject:tagButton];
    
    [self updateFrame];
    
    self.textField.text = nil;
    self.addBtn.hidden = YES;
    
}
- (void)updateFrame
{
    for (int i = 0; i<self.tagArray.count; i++) {
        BDJTagButton *tagBtn = self.tagArray[i];
        if (i == 0) {
            tagBtn.x = 0;
            tagBtn.y = 0;
        }else
        {
            BDJTagButton *lastTagBtn = self.tagArray[i - 1];
            //计算左边的已经添加的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagBtn.frame) + tagMargin;
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagBtn.width) {
                //在当前行
                tagBtn.y = lastTagBtn.y;
                tagBtn.x = leftWidth;
            }else
            {
                //不在当前行
                tagBtn.x = 0;
                tagBtn.y = CGRectGetMaxY(lastTagBtn.frame) + tagMargin;
            }
        }
    }
    //更新textFile
    BDJTagButton *lastTagBtn = [self.tagArray lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagBtn.frame) + tagMargin;
    if (self.contentView.width - leftWidth >= self.textField.width) {
        self.textField.y = lastTagBtn.y;
        self.textField.x = leftWidth;
    }else
    {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagBtn.frame) + tagMargin;
    }
    
}
- (void)tagButtonClick:(BDJTagButton *)tagBtn
{
    [tagBtn removeFromSuperview];
    [self.tagArray removeObject:tagBtn];
    
    // 重新更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateFrame];
    }];

}
#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 1) {
        [self addButtonClick];
    }
    return YES;
}
@end
