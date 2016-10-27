//
//  SYExpressionsViewController.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/10/8.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYExpressionsViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define SYExpressionSrcName(file) [@"Expressions.bundle" stringByAppendingPathComponent:file]

#define ItemW 24
#define ItemMarginH (ScreenW - ItemW*7)/8
#define ItemMarginV (self.scrollView.frame.size.height - ItemW * 3)/4

@interface SYExpressionsViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation SYExpressionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.sendBtn];
    [self.view addSubview:self.pageControl];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for (int i = 0; i < 105; i++) {
        
        NSInteger row = i/7;
        NSInteger col = i%7;
        NSInteger page = row/3;
        
        CGFloat x = ItemMarginH * (col + 1) + ItemW * col + page * ScreenW;
        CGFloat y = ItemMarginV * (row % 3 + 1) + ItemW *(row % 3) + 10;
        
        if ((i+1)%21 == 0) {
            UIButton *deleateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [deleateBtn setBackgroundImage:[UIImage imageNamed:@"emoji_btn_delete"] forState:UIControlStateNormal];
            [deleateBtn addTarget:self action:@selector(expressionBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
            deleateBtn.tag = 999;
            deleateBtn.frame = CGRectMake(x, y, 30, 20);
            [self.scrollView addSubview:deleateBtn];
        }else {
            NSInteger index = i+1-page;
            NSString *imageName = [NSString stringWithFormat:@"Expression_%zd",index];
            UIImage *image = [UIImage imageNamed:SYExpressionSrcName(imageName)];
            UIButton *expression = [UIButton buttonWithType:UIButtonTypeCustom];
            expression.tag = i + 1000 -page;
            expression.frame = CGRectMake(x, y, ItemW, ItemW);
            [expression setBackgroundImage:image forState:UIControlStateNormal];
            [expression addTarget:self action:@selector(expressionBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.scrollView addSubview:expression];
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * (105/21), self.scrollView.frame.size.height);
}

- (void)expressionBtnSelected:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sy_ExpressionsDidSelectedImage:)]) {
        if (sender.tag == 999) {
            [self.delegate sy_ExpressionsDidSelectedImage:nil];
        }else {
            NSString *imageName = [NSString stringWithFormat:@"Expression_%zd",sender.tag - 1000+1];
            UIImage *image = [UIImage imageNamed:SYExpressionSrcName(imageName)];
            [self.delegate sy_ExpressionsDidSelectedImage:image];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / ScreenW;
}

- (void)sendMessage {
    if ([self.delegate respondsToSelector:@selector(sy_ExpressionsSendMessage)]) {
        [self.delegate sy_ExpressionsSendMessage];
    }
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 148)];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIButton *)sendBtn {
    if (_sendBtn == nil) {
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 53, 183, 53, 35)];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setBackgroundColor:[UIColor sy_colorWithRGB:0x157EFA]];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 148, ScreenW, 35)];
        _pageControl.numberOfPages = 5;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    }
    return _pageControl;
}
@end
