//
//  RTHCircleViewController.m
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/10/11.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHCircleViewController.h"
#import "RTHCircleDynamicViewController.h"
#import "RTHCircleMineViewController.h"
#import "RTHCirCleMoreViewController.h"

@interface RTHCircleViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation RTHCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationItem.titleView = self.segmentedControl;
    [self.view addSubview:self.scrollView];
    
    [self setNavigationItems];
    [self setControllers];
}

- (void)setControllers {
    NSArray *controllers = @[[RTHCircleDynamicViewController class],[RTHCircleMineViewController class],[RTHCirCleMoreViewController class]];
    
    for (int i = 0; i < controllers.count; i++) {
        Class vcClass = controllers[i];
        UIViewController *vc = [[vcClass alloc] initWithNibName:NSStringFromClass(vcClass) bundle:nil];
        [self addChildViewController:vc];

        CGFloat x = i*ScreenW;
        vc.view.frame = CGRectMake(x, 0, ScreenW,self.scrollView.sy_height);
        [self.scrollView addSubview:vc.view];
    }
    
    self.scrollView.contentSize = CGSizeMake(ScreenW * controllers.count,self.scrollView.sy_height);
}

- (void)setNavigationItems {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonItemClick)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"circle_search"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonItemClick)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)leftButtonItemClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonItemClick {
    NSLog(@"搜索");
}

- (void)segmentedControlClick:(UISegmentedControl *)sender {
    [self.scrollView setContentOffset:CGPointMake(ScreenW*sender.selectedSegmentIndex, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = (NSInteger)(scrollView.contentOffset.x/ScreenW);
    [self.segmentedControl setSelectedSegmentIndex:index];
}

- (UISegmentedControl *)segmentedControl {
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"动态",@"我的",@"更多圈子"]];
        _segmentedControl.frame = CGRectMake(0, 0, 220, 32);
        _segmentedControl.tintColor = [UIColor whiteColor];
        [_segmentedControl setSelectedSegmentIndex:0];
        [_segmentedControl addTarget:self action:@selector(segmentedControlClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
//        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

@end
