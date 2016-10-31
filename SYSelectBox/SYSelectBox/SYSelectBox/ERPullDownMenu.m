//
//  ERPullDownMenu.m
//  ESFManager
//
//  Created by leju_esf on 16/5/27.
//  Copyright © 2016年 leju. All rights reserved.
//

#import "ERPullDownMenu.h"

#define ANIMATION_DURATION      0.5f
#define MENU_ITEM_HEIGHT        30
#define FONT_SIZE               13
#define ARROW_HEIGHT            10
#define CONERRADIUS             8

@interface ERPullDownMenu() <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
{
    CGPoint _arrowPoint;
}

// 真实容器
@property(nonatomic,strong) UIView *containerView;
@property(nonatomic,retain) NSArray *dataSrc;
@property(nonatomic,assign) ERPullDownMenuPointDirection direction;
@property(nonatomic,strong) UIView *bgView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ERPullDownMenu
- (instancetype)initWithSize:(CGSize)size withData:(NSArray *) dataSrcArray AndDirection:(ERPullDownMenuPointDirection) direction {
    if (size.height > 200) {
        size = CGSizeMake(size.width, 200);
    }
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    if (self) {
        self.dataSrc = dataSrcArray;
        self.direction = direction;
        self.backgroundColor = [UIColor whiteColor];
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, ARROW_HEIGHT, size.width, size.height - ARROW_HEIGHT)];
        [self.containerView setBackgroundColor:[UIColor clearColor]];
        
        // 添加TableView
        UITableView *menuItemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - ARROW_HEIGHT)];
        menuItemsTableView.dataSource = self;
        menuItemsTableView.delegate = self;
        menuItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        menuItemsTableView.scrollEnabled = YES;
        menuItemsTableView.backgroundColor = [UIColor clearColor];
        self.tableView = menuItemsTableView;
        [self.containerView addSubview:menuItemsTableView];
        [self drowRect];
        [self addSubview:self.containerView];
        
        [ERCommonTool registerNibWithClass:[ERPullDownCell class] forTabelView:menuItemsTableView];
    }
    
    return self;
}

-(void)drowRect {
    // 边界值
    CGFloat left, right, top, bottom;
    // 尖角宽度
    CGFloat arrowWidth = 15;
    // 尖角左右边X位置
    CGFloat arrowLeftX, arrowRightX;
    
    
    left = 0.0;
    right = CGRectGetWidth(self.frame);
    top = ARROW_HEIGHT;
    bottom = CGRectGetHeight(self.frame);
    if (_direction == ERPullDownMenuPointDirectionRight) {
        arrowRightX = right - 10;
        arrowLeftX = right - 10 - arrowWidth;
    } else if (_direction == ERPullDownMenuPointDirectionLeft){
        arrowRightX = 10 + arrowWidth;
        arrowLeftX = 10;
    } else {
        arrowRightX = (right + arrowWidth)*0.5;
        arrowLeftX = (right - arrowWidth)*0.5;
    }
    
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    //start
    [path moveToPoint:CGPointMake(left, CONERRADIUS+top)];
    
    //left
    [path addLineToPoint:CGPointMake(left, bottom-CONERRADIUS)];
    [path addQuadCurveToPoint:CGPointMake(left+CONERRADIUS, bottom) controlPoint:CGPointMake(left, bottom)];
    
    //bottom
    [path addLineToPoint:CGPointMake(right-CONERRADIUS, bottom)];
    [path addQuadCurveToPoint:CGPointMake(right, bottom-CONERRADIUS) controlPoint:CGPointMake(right, bottom)];
    
    //right
    [path addLineToPoint:CGPointMake(right, CONERRADIUS+top)];
    [path addQuadCurveToPoint:CGPointMake(right-CONERRADIUS, top) controlPoint:CGPointMake(right, top)];
    
    //arrow
    _arrowPoint = CGPointMake(arrowRightX - arrowWidth/2, 0);
    [path addLineToPoint:CGPointMake(arrowRightX, top)];
    [path addLineToPoint:CGPointMake(arrowRightX - arrowWidth/2, 0)];
    [path addLineToPoint:CGPointMake(arrowLeftX, top)];
    
    //top
    [path addLineToPoint:CGPointMake(left+CONERRADIUS, top)];
    [path addQuadCurveToPoint:CGPointMake(left, CONERRADIUS+top) controlPoint:CGPointMake(left, top)];
    
    CAShapeLayer *cornerMaskLayer = [CAShapeLayer layer];
    [cornerMaskLayer setPath:path.CGPath];
    self.layer.mask = cornerMaskLayer;
    
    // 添加轮廓线
    CAShapeLayer *borderLayer=[CAShapeLayer layer];
    borderLayer.path    =   path.CGPath;
    borderLayer.fillColor  = [UIColor clearColor].CGColor;
    borderLayer.strokeColor    = [UIColor lightGrayColor].CGColor;
    borderLayer.lineWidth      = 1;
    borderLayer.frame=self.bounds;
    [self.layer addSublayer:borderLayer];
}

#pragma mark UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MENU_ITEM_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSrc count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ERPullDownCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ERPullDownCell class])];

    cell.model = self.dataSrc[indexPath.row];
    cell.checked = self.selectedIndex == indexPath.row;
    return cell;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hide];
    if (self.selectedAction) {
        self.selectedAction(indexPath.row);
    }
    self.selectedIndex = indexPath.row;
    [tableView reloadData];
}

#pragma mark -
#pragma mark Actions

- (void)dismiss{
    [self hide];
}

- (void)showDependentOn:(UIView *)dependentView {
    CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:dependentView.frame fromView:dependentView.superview];
    
    CGRect frame = CGRectZero;
    
    CGFloat y = CGRectGetMaxY(rect);
    
    if (self.direction == ERPullDownMenuPointDirectionLeft) {
        frame = CGRectMake(rect.origin.x+rect.size.width * 0.5 - 20, y, self.frame.size.width, self.frame.size.height);
    }else if (self.direction == ERPullDownMenuPointDirectionRight) {
        frame = CGRectMake(rect.origin.x+rect.size.width * 0.5 - self.frame.size.width + 20,y, self.frame.size.width, self.frame.size.height);
    }else {
        frame = CGRectMake(rect.origin.x+rect.size.width * 0.5 - self.frame.size.width * 0.5,y, self.frame.size.width, self.frame.size.height);
    }
    self.frame = frame;
    
    //添加阴影
    self.bgView.layer.shadowPath =  [UIBezierPath bezierPathWithRect:CGRectMake(self.frame.origin.x, self.frame.origin.y + 10, self.frame.size.width, self.frame.size.height - 10) ].CGPath;
    self.bgView.layer.shadowOffset = CGSizeMake(5, 5);
    self.bgView.layer.shadowRadius = 5;
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOpacity = 0.4;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alpha = 1.0;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, _arrowPoint.x - CGRectGetWidth(self.frame)/2.0, _arrowPoint.y - CGRectGetHeight(self.frame)/2.0);
    transform = CGAffineTransformScale(transform, 0.01, 0.01);
    self.transform = transform;
    self.alpha = 0.01;
    [UIView animateWithDuration:ANIMATION_DURATION delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)tapGecognizer:(UITapGestureRecognizer *)tapGecognizer{
    [self hide];
    if (self.selectedAction) {
        self.selectedAction(-1);
    }
}

- (void)hide {
     self.bgView.layer.shadowPath =  [UIBezierPath bezierPathWithRect:CGRectZero].CGPath;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, _arrowPoint.x - CGRectGetWidth(self.frame)/2.0, _arrowPoint.y - CGRectGetHeight(self.frame)/2.0);
    transform = CGAffineTransformScale(transform, 0.01, 0.01);
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = transform;
        self.alpha = 0.01;
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return touch.view.tag == 9999;
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tapGecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGecognizer:)];
        tapGecognizer.delegate = self;
        [_bgView addGestureRecognizer:tapGecognizer];
        _bgView.tag = 9999;
    }
    return _bgView;
}

@end
