//
//  RTHChatViewController.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/9/29.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHChatViewController.h"
#import "SYExpressionsViewController.h"
#import "RTHChatCell.h"

@interface RTHChatViewController ()<SYExpressionsViewControllerDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomMargin;
@property (nonatomic, strong) SYExpressionsViewController *expressionVC;
@property (weak, nonatomic) IBOutlet UIButton *expressionBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSMutableArray *messages;
@end

@implementation RTHChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [self.tableView sy_registerNibWithClass:[RTHChatCell class]];
    
    self.tableView.estimatedRowHeight = 45;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addChildViewController:self.expressionVC];
    [self.view addSubview:self.expressionVC.view];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)keyBoardWillAppear:(NSNotification *)noti {
    NSValue *value = noti.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect bounds = [value CGRectValue];
    [self toolBarBottomMargin:bounds.size.height];
    
    if (self.expressionBtn.selected) {
        self.expressionBtn.selected = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self.expressionVC.view.sy_y = ScreenH;
        }];
    }
    
    if (self.messages.count > 0) {
       [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messages.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [self toolBarBottomMargin:0];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"] && textView.attributedText.length > 0) {
        [self sy_ExpressionsSendMessage];
        return NO;
    }else if (text.length > 0) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        [attriStr appendAttributedString:str];
        textView.attributedText = attriStr;
        [textView setContentOffset:CGPointMake(0, textView.contentSize.height - textView.sy_height) animated:YES];
        return NO;
    }else {
        return YES;
    }
}

- (void)toolBarBottomMargin:(CGFloat)margin {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.toolBarBottomMargin.constant = margin;
        [self.view layoutIfNeeded];
    }];
}

- (void)sy_ExpressionsSendMessage {
    RTHChatMessage *message = [[RTHChatMessage alloc] init];
    message.message = self.textView.attributedText;
    message.isMyself = self.messages.count % 2 == 0;
    [self.messages addObject:message];
    self.textView.attributedText = nil;
    self.textView.text = nil;
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messages.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    });
}

- (IBAction)voiceAction:(UIButton *)sender {
    
}

- (IBAction)smileAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        [self.textView resignFirstResponder];
        [self toolBarBottomMargin:218];
        [UIView animateWithDuration:0.25 animations:^{
            self.expressionVC.view.sy_y = ScreenH - 218;
        }];
    }else {
        [self.textView becomeFirstResponder];
        [UIView animateWithDuration:0.25 animations:^{
            self.expressionVC.view.sy_y = ScreenH;
        }];
    }
    if (self.messages.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messages.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (IBAction)addAction:(UIButton *)sender {
    
}

- (void)sy_ExpressionsDidSelectedImage:(UIImage *)image {
    if (image) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
        NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        attach.bounds = CGRectMake(0,-5,24, 24);
        attach.image = image;
        NSAttributedString *strAtt = [NSAttributedString attributedStringWithAttachment:attach];
        [attriStr appendAttributedString:strAtt];
        self.textView.attributedText = attriStr;
    }else {
        if (self.textView.attributedText.length > 0) {
            self.textView.attributedText = [self.textView.attributedText attributedSubstringFromRange:NSMakeRange(0, self.textView.attributedText.length - 1)];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTHChatCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RTHChatCell class])];
    cell.message = self.messages[indexPath.row];
    return cell;
}

- (SYExpressionsViewController *)expressionVC {
    if (_expressionVC == nil) {
        _expressionVC = [[SYExpressionsViewController alloc] init];
        _expressionVC.view.frame = CGRectMake(0,ScreenH, ScreenW, 218);
        _expressionVC.delegate = self;
    }
    return _expressionVC;
}

- (NSMutableArray *)messages {
    if (_messages == nil) {
        _messages = [[NSMutableArray alloc] init];
    }
    return _messages;
}
@end
