//
//  RTHViewController.m
//  SYSlideDemo
//
//  Created by sy_esf on 16/9/19.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHExpertViewController.h"
#import "SYSlideSelectedView.h"
#import "RTHIntroductViewController.h"
#import "RTHCoursesViewController.h"
#import "RTHQuestionAnswerViewController.h"
#import "RTHEvaluateViewController.h"
#import "RTHExpertTagsView.h"

@interface RTHExpertViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) SYSlideSelectedView *slideView;
@property (nonatomic, assign) BOOL isAnimation;
@property (weak, nonatomic) IBOutlet UIButton *onLineChat;
@property (weak, nonatomic) IBOutlet UIButton *personCoach;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *careBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTopMargin;
@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet RTHExpertTagsView *tagsView;
@end

@implementation RTHExpertViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (IBAction)backAciton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tagsView.tags = @[@"实力派",@"高颜值",@"幽默",@"耐心细致"];
    self.navBarView.alpha = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.middleView addSubview:self.slideView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self clipsCornerWithView:self.onLineChat];
    [self clipsCornerWithView:self.personCoach];
    [self clipsCornerWithView:self.careBtn];
    
    NSArray *controllers = @[[RTHIntroductViewController class],[RTHCoursesViewController class],[RTHQuestionAnswerViewController class],[RTHEvaluateViewController class]];
    
    for (int i = 0; i < controllers.count; i++) {
        Class vcClass = controllers[i];
        UITableViewController *vc = [[vcClass alloc] init];
        [self addChildViewController:vc];
        
        CGFloat x = i*ScreenW;
        vc.view.frame = CGRectMake(x, 0, ScreenW,ScreenH-64-45);
        [self.scrollView addSubview:vc.view];
    }
    
    self.scrollView.contentSize = CGSizeMake(ScreenW * controllers.count, self.scrollView.sy_height);
    
    [self addNotification];
}

- (void)clipsCornerWithView:(UIView *)clipView {
    clipView.layer.cornerRadius = clipView.sy_height * 0.5;
    clipView.clipsToBounds = YES;
    clipView.layer.borderColor = [UIColor sy_colorWithRGB:0xD92724].CGColor;
    clipView.layer.borderWidth = 1.0;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changTopMargin:) name:SYTableViewContentOffsetChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endChangeTopMargin) name:SYTableViewContentOffsetChangeEndNotification object:nil];
}

- (void)changTopMargin:(NSNotification *)noti {
    NSValue *value = noti.userInfo[@"offset"];
    CGPoint offset = [value CGPointValue];
    if (offset.y > -316 && offset.y < 0) {
        self.topViewTopMargin.constant = (offset.y + 316)*(-1);
        self.navBarView.alpha = (316 + offset.y)/316;
    }else if (offset.y >= 0) {
        self.topViewTopMargin.constant = -316;
        self.navBarView.alpha = 1;
    }else if (offset.y <= -316) {
        self.topViewTopMargin.constant = 0;
        self.navBarView.alpha = 0;
    }
}

- (void)endChangeTopMargin {
    [self layoutSubTableViewContentOffset];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self layoutSubTableViewContentOffset];
    });
}

- (void)layoutSubTableViewContentOffset {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for (int i = 0 ; i < self.childViewControllers.count ;i++) {
        
        if (self.slideView.selectedIndex == i) {
            continue;
        }
        
        UITableViewController *tableVC = self.childViewControllers[i];
        
        if (self.topViewTopMargin.constant == -316) {
            if (tableVC.tableView.contentOffset.y >= -316 && tableVC.tableView.contentOffset.y < 0) {
                tableVC.tableView.contentOffset = CGPointMake(0, 0);
            }
        }else {
            tableVC.tableView.contentOffset = CGPointMake(0,-self.topViewTopMargin.constant - 316);
        }
        
        if (tableVC.tableView.contentSize.height < ScreenH - 109) {
            tableVC.tableView.contentInset = UIEdgeInsetsMake(tableVC.tableView.contentInset.top, tableVC.tableView.contentInset.left, ScreenH - 109 - tableVC.tableView.contentSize.height, tableVC.tableView.contentInset.right);
        }
    }
    
    [self addNotification];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.slideView slideLineOffset:scrollView.contentOffset.x/self.slideView.titles.count];
}

- (SYSlideSelectedView *)slideView {
    if (_slideView == nil) {
        _slideView = [[SYSlideSelectedView alloc] initWithTitles:@[@"专家简介",@"专家课程",@"专家问答",@"学员评价"] frame:CGRectMake(0,90, ScreenW, 45) normalColor:[UIColor sy_colorWithRGB:0x000000] andSelectedColor:[UIColor sy_colorWithRGB:0xde2418]];
        __weak typeof(self) weakSelf = self;
        [_slideView setButtonAciton:^(NSInteger index) {
            [weakSelf.scrollView setContentOffset:CGPointMake(index*weakSelf.scrollView.sy_width, 0)animated:YES];
            [weakSelf layoutSubTableViewContentOffset];
        }];
    }
    return _slideView;
}

@end
