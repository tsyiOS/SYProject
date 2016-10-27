//
//  RTHCoursesCheckViewController.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/9/28.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHCoursesCheckViewController.h"
#import "RTHCoursesDetailViewController.h"
#import "RTHCoursesEvaluateViewController.h"
#import "RTHCoursesContentsViewController.h"
#import "SYSlideSelectedView.h"
#import "RTHCoursesBottomBarView.h"
#import "RTHCoursesDownLoadViewController.h"

#define MiddleViewTopMargin  (ScreenW/375) * 210

@interface RTHCoursesCheckViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;
@property (weak, nonatomic) IBOutlet UILabel *collectionText;
@property (weak, nonatomic) IBOutlet UIView *bottomButtonView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) RTHCoursesBottomBarView *bottomBar;
@property (nonatomic, strong) SYSlideSelectedView *slideView;
@property (nonatomic, strong) RTHCoursesDownLoadViewController *downLoadVc;
@end

@implementation RTHCoursesCheckViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.topViewHeight.constant = MiddleViewTopMargin;

    [self.middleView addSubview:self.slideView];
    [self addContentViews];
    [self.bottomButtonView addSubview:self.bottomBar];
}

- (void)addContentViews {
    NSArray *controllers = @[[RTHCoursesContentsViewController class],[RTHCoursesDetailViewController class],[RTHCoursesEvaluateViewController class]];
    
    for (int i = 0; i < controllers.count; i++) {
        Class vcClass = controllers[i];
        UITableViewController *vc = [[vcClass alloc] init];
        vc.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addChildViewController:vc];
        
        vc.view.tag = i+1000;
        CGFloat x = i*ScreenW;
        vc.view.frame = CGRectMake(x, 0, ScreenW+50,self.scrollView.sy_height);
        [self.scrollView addSubview:vc.view];
    }
    self.scrollView.contentSize = CGSizeMake(ScreenW * controllers.count, self.scrollView.sy_height);
    
    [self addChildViewController:self.downLoadVc];
    [self.view addSubview:self.downLoadVc.view];
}

- (void)orientChange:(NSNotification *)noti {
    self.topViewHeight.constant = [UIDevice currentDevice].orientation == UIDeviceOrientationPortrait?  MiddleViewTopMargin:ScreenH;
    self.scrollView.sy_y = [UIDevice currentDevice].orientation == UIDeviceOrientationPortrait?MiddleViewTopMargin + 45:ScreenH;
    self.backBtn.hidden = [UIDevice currentDevice].orientation != UIDeviceOrientationPortrait;
}

- (IBAction)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.slideView slideLineOffset:scrollView.contentOffset.x/self.slideView.titles.count];
}

/**
 *  下载
 */
- (void)downLoad {
    [UIView animateWithDuration:0.25 animations:^{
        self.downLoadVc.view.frame = CGRectMake(0,  self.topViewHeight.constant, ScreenW, ScreenH - self.topViewHeight.constant);
    }];
    
}
/**
 *  收藏
 */
- (void)cllection {
    
    NSLog(@"收藏");
}
/**
 *  分享
 */
- (void)share {
    NSLog(@"分享");
}
/**
 *  打赏
 */
- (void)reward {
    NSLog(@"打赏");
}
/**
 *  课程评价
 */
- (IBAction)coursesEvaluate {
    NSLog(@"课程评价");
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, MiddleViewTopMargin + 45, ScreenW, ScreenH - MiddleViewTopMargin-45-49.5)];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (SYSlideSelectedView *)slideView {
    if (_slideView == nil) {
        _slideView = [[SYSlideSelectedView alloc] initWithTitles:@[@"目录",@"详情",@"评价"] frame:CGRectMake(0,0, ScreenW, self.middleView.sy_height) normalColor:[UIColor sy_colorWithRGB:0x000000] andSelectedColor:[UIColor sy_colorWithRGB:0xde2418]];
        __weak typeof(self) weakSelf = self;
        [_slideView setButtonAciton:^(NSInteger index) {
            [weakSelf.scrollView setContentOffset:CGPointMake(index*weakSelf.scrollView.sy_width, 0)animated:YES];
        }];
    }
    return _slideView;
}

- (RTHCoursesBottomBarView *)bottomBar {
    if (_bottomBar == nil) {
        _bottomBar = [[RTHCoursesBottomBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 116, self.bottomButtonView.sy_height) andTitles:@[@"下载",@"收藏",@"分享",@"打赏"]andImageNames:@[@"course_download",@"courses_shoucang",@"courses_fenxiang",@"courses_dashang"]];
        __weak typeof(self) weakSelf = self;
        [_bottomBar setBottomBtnClick:^(RTHCoursesBottomClickType type) {
            switch (type) {
                case RTHCoursesBottomClickTypeDownLoad:
                    [weakSelf downLoad];
                    break;
                case RTHCoursesBottomClickTypeCollection:
                    [weakSelf cllection];
                    break;
                case RTHCoursesBottomClickTypeShare:
                    [weakSelf share];
                    break;
                case RTHCoursesBottomClickTypeReward:
                    [weakSelf reward];
                    break;
            }
        }];
    }
    return _bottomBar;
}

- (RTHCoursesDownLoadViewController *)downLoadVc {
    if (_downLoadVc == nil) {
        _downLoadVc = [[RTHCoursesDownLoadViewController alloc] initWithNibName:NSStringFromClass([RTHCoursesDownLoadViewController class]) bundle:nil];
        _downLoadVc.view.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH - self.topViewHeight.constant);
        NSLog(@"%@",NSStringFromCGRect(_downLoadVc.view.frame));
    }
    return _downLoadVc;
}

@end
