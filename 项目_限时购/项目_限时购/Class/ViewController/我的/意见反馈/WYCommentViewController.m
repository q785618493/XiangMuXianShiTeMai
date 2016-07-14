//
//  WYCommentViewController.m
//  项目_限时购
//
//  Created by ma c on 16/7/12.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYCommentViewController.h"

@interface WYCommentViewController () <UITextViewDelegate,UITextFieldDelegate>

/** 背部视图 */
@property (strong, nonatomic) UIView *bgView;

/** 反馈意见 */
@property (strong, nonatomic) UITextView *commentTextView;

/** 提示信息 */
@property (strong, nonatomic) UILabel *alertLabel;

/** 联系方式 */
@property (strong, nonatomic) UITextField *contactText;

/** 提交按钮 */
@property (strong, nonatomic) UIButton *submitBtn;

@end

@implementation WYCommentViewController

/** 懒加载 */
- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] init];
        [_alertLabel setBackgroundColor:[UIColor whiteColor]];
        [_alertLabel setTextColor:RGB(200, 200, 206)];
        [_alertLabel setNumberOfLines:0];
        [_alertLabel setFont:[UIFont systemFontOfSize:14]];
        [_alertLabel setText:[NSString stringWithFormat:@"亲爱的用户:感谢您的每一次的反馈，这是我们成长过程中收到的最宝贵的礼物"]];
        CGFloat height = [NSString autoHeightWithString:[NSString stringWithFormat:@"亲爱的用户:感谢您的每一次的反馈，这是我们成长过程中收到的最宝贵的礼物"] Width:VIEW_WIDTH - 56 Font:[UIFont systemFontOfSize:15]];
        [_alertLabel setFrame:(CGRectMake(8, 8, VIEW_WIDTH - 56, height))];
    }
    return _alertLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:(CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 64))];
        [_bgView setBackgroundColor:RGB(245, 245, 245)];
    }
    return _bgView;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_submitBtn setBackgroundColor:RGB(55, 183, 236)];
        [_submitBtn.layer setCornerRadius:5];
        [_submitBtn setTitle:[NSString stringWithFormat:@"提交反馈"] forState:(UIControlStateNormal)];
        [_submitBtn addTarget:self action:@selector(btnTouchActionSubmit) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _submitBtn;
}

- (UITextField *)contactText {
    if (!_contactText) {
        _contactText = [[UITextField alloc] init];
        [_contactText setBackgroundColor:[UIColor whiteColor]];
        [_contactText setBorderStyle:(UITextBorderStyleRoundedRect)];
        [_contactText.layer setMasksToBounds:YES];
        [_contactText.layer setCornerRadius:5];
        [_contactText setDelegate:self];
        [_contactText setPlaceholder:[NSString stringWithFormat:@"联系方式(电话或者QQ等)"]];
        [_contactText setFont:[UIFont systemFontOfSize:19]];
    }
    return _contactText;
}

- (UITextView *)commentTextView {
    if (!_commentTextView) {
        _commentTextView = [[UITextView alloc] init];
        [_commentTextView setBackgroundColor:[UIColor whiteColor]];
        [_commentTextView setFont:[UIFont systemFontOfSize:14]];
        [_commentTextView setDelegate:self];
        [_commentTextView setTextAlignment:(NSTextAlignmentLeft)];
        
        //显示数据类型的连接模式（如电话号码、网址、地址等）
        [_commentTextView setScrollEnabled:YES];
        
        //显示数据类型的连接模式（如电话号码、网址、地址等）
        [_commentTextView setDataDetectorTypes:(UIDataDetectorTypeAll)];
        
        [_commentTextView.layer setMasksToBounds:YES];
        [_commentTextView.layer setCornerRadius:5];
    }
    return _commentTextView;
}

- (void)btnTouchActionSubmit {
    
    if ([self.contactText.text isEmptyString]) {
        
        [self showTostView:[NSString stringWithFormat:@"联系方式不能为空"]];
    }
    else if ([self.commentTextView.text isEmptyString]) {
        [self showTostView:[NSString stringWithFormat:@"反馈意见不能为空"]];
    }
    else {
        [self.view endEditing:YES];
        [self showTostView:[NSString stringWithFormat:@"我们会尽快解决您遇到的问题"]];
        WS(weakSelf);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"意见反馈"];
    
    [self controlAddViewMasonry];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.contactText becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)controlAddViewMasonry {
    
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.contactText];
    [self.bgView addSubview:self.commentTextView];
    [self.commentTextView addSubview:self.alertLabel];
    [self.bgView addSubview:self.submitBtn];
    
    WS(weakSelf)
    [_contactText makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.left).offset(20);
        make.right.equalTo(weakSelf.bgView.right).offset(-20);
        make.top.equalTo(weakSelf.bgView.top).offset(10);
        make.height.equalTo(40);
    }];
    
    [_commentTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.left).offset(20);
        make.right.equalTo(weakSelf.bgView.right).offset(-20);
        make.top.equalTo(weakSelf.contactText.bottom).offset(10);
        make.height.equalTo(VIEW_WIDTH - 100);
    }];
    
    [_submitBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.left).offset(60);
        make.right.equalTo(weakSelf.bgView.right).offset(-60);
        make.top.equalTo(weakSelf.commentTextView.bottom).offset(10);
        make.height.equalTo(35);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma make-
#pragma make- UITextViewDelegate
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    return YES;
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}

//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView {
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.navigationController.navigationBar setHidden:YES];
        CGRect rect = weakSelf.view.bounds;
        rect.origin.y = 100;
        [weakSelf.view setBounds:rect];
    }];
}

//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.navigationController.navigationBar setHidden:NO];
        CGRect rect = weakSelf.view.bounds;
        rect.origin.y = 0;
        [weakSelf.view setBounds:rect];
    }];
}

//内容将要发生改变编辑
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    return YES;
}

//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView.text isEmptyString]) {
        [self.alertLabel setHidden:NO];
    }
    else {
        [self.alertLabel setHidden:YES];
    }
}

//焦点发生改变
- (void)textViewDidChangeSelection:(UITextView *)textView {

}

/*
 有时候我们要控件自适应输入的文本的内容的高度，只要在textViewDidChange的代理方法中加入调整控件大小的代理即可
*/

//- (void)textViewDidChange:(UITextView *)textView {
//    //计算文本的高度
//    CGSize constraintSize;
//    constraintSize.width = textView.frame.size.width-16;
//    constraintSize.height = MAXFLOAT;
//    CGSize sizeFrame =[textView.text sizeWithFont:textView.font
//                                constrainedToSize:constraintSize
//                                    lineBreakMode:UILineBreakModeWordWrap];
//    
//    //重新调整textView的高度
//    textView.frame = CGRectMake(textView.frame.origin.x,textView.frame.origin.y,textView.frame.size.width,sizeFrame.height+5);
//}


////控制输入文字的长度和内容，可通调用以下代理方法实现
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if (range.location>=100)
//    {
//        //控制输入文本的长度
//        return  NO;
//    }
//    if ([text isEqualToString:@"\n"]) {
//        //禁止输入换行
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}
//
///*
//UITextView退出键盘的几种方式
//因为iphone的软键盘没有自带的退键盘键，所以要实现退出键盘需要自己实现，有如下几种方式：
//1）如果你程序是有导航条的，可以在导航条上面加多一个Done的按钮，用来退出键盘，当然要先实UITextViewDelegate。*/
//- (void)textViewDidBeginEditing:(UITextView *)textView {
//    
//    UIBarButtonItem *done =    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                                             target:self
//                                                                             action:@selector(dismissKeyBoard)];
//    
//    self.navigationItem.rightBarButtonItem = done;
//    
//    [done release];
//    done = nil;
//    
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView {
//    self.navigationItem.rightBarButtonItem = nil;
//}
//
//- (void)dismissKeyBoard {
//    [self.commentTextView resignFirstResponder];
//}
//
//
////2）如果你的textview里不用回车键，可以把回车键当做退出键盘的响应键。 代码如下：
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

#pragma make-
#pragma make- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.commentTextView becomeFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
