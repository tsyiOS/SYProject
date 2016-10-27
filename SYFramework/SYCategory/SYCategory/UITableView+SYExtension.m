
#import "UITableView+SYExtension.h"
#import <objc/runtime.h>
#import "SYHeaderRefreshView.h"
#import "UIView+SYExtension.h"

#define SYRefreshTopHeight 50

@interface UITableView ()
@property (nonatomic, strong) SYHeaderRefreshView *refreshView;
@property (nonatomic, strong) NSNumber *isObserved;
@end

@implementation UITableView (SYExtension)

@dynamic sy_headerRefresh;

- (void)sy_observeTableViewContentOffset {
    self.isObserved = [NSNumber numberWithInteger:1];
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [self.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)  change context:(void *)context {
    if ([keyPath isEqualToString:@"state"]) {
        NSInteger state = [change[@"new"] integerValue];
        if (state == 3) {
            [[NSNotificationCenter defaultCenter] postNotificationName:SYTableViewContentOffsetChangeEndNotification object:self];
            [self sy_judgeRefresh];
        }
        
    }else if([keyPath isEqualToString:@"contentOffset"]){
        
        NSValue *pointValue = change[@"new"];
        [[NSNotificationCenter defaultCenter] postNotificationName:SYTableViewContentOffsetChangeNotification object:self userInfo:@{@"offset":pointValue}];
        [self sy_changeRefreshTitle];
    }
}


- (void)sy_judgeRefresh {
    if (self.contentOffset.y <= -(SYRefreshTopHeight + self.contentInset.top)) {
        [self sy_beginRefresh];
    }
}

- (void)sy_changeRefreshTitle {
    if (self.refreshView.status != SYRefreshing) {
        if (self.contentOffset.y > -(SYRefreshTopHeight + self.contentInset.top)) {
            self.refreshView.status = SYRefreshPullDown;
        }else {
            self.refreshView.status = SYRefreshReady;
        }
    }
}

- (void)sy_beginRefresh {
    if (self.refreshView.status != SYRefreshing && self.sy_headerRefresh) {
        self.contentInset = UIEdgeInsetsMake(SYRefreshTopHeight + self.contentInset.top, 0, 1, 0);
        self.refreshView.status = SYRefreshing;
        if (self.sy_headerRefresh) {
            self.sy_headerRefresh();
        }
    }
}

- (void)sy_endRefresh {
    [UIView animateWithDuration:0.25 animations:^{
        self.contentInset = UIEdgeInsetsMake(self.contentInset.top-SYRefreshTopHeight, 0, 1, 0);
    }];
    self.refreshView.status = SYRefreshPullDown;
}

static const char SY_RefreshKey = '\1';
static const char SY_RefreshViewKey = '\2';
static const char SY_IsObservedKey = '\3';
- (void)setSy_headerRefresh:(void (^)())sy_headerRefresh {
    if ([self.isObserved integerValue] != 1) {
        [self sy_observeTableViewContentOffset];
    }
    if (self.refreshView == nil) {
        SYHeaderRefreshView *refreshView = [[SYHeaderRefreshView alloc] initWithFrame:CGRectMake(0, -SYRefreshTopHeight, ScreenW, SYRefreshTopHeight)];
        [self addSubview:refreshView];
        objc_setAssociatedObject(self, &SY_RefreshViewKey, refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self, &SY_RefreshKey, sy_headerRefresh, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)())sy_headerRefresh {
    return objc_getAssociatedObject(self, &SY_RefreshKey);
}

- (SYHeaderRefreshView *)refreshView {
    return objc_getAssociatedObject(self, &SY_RefreshViewKey);
}

- (void)setIsObserved:(NSNumber *)isObserved {
    objc_setAssociatedObject(self, &SY_IsObservedKey, isObserved, OBJC_ASSOCIATION_ASSIGN);
}

- (NSNumber *)isObserved {
    return  objc_getAssociatedObject(self, &SY_IsObservedKey);
}

- (void)dealloc {
    if ([self.isObserved integerValue] == 1) {
        [self removeObserver:self forKeyPath:@"contentOffset"];
        [self.panGestureRecognizer removeObserver:self forKeyPath:@"state"];
    }
}

#pragma mark - 注册cell
- (void)sy_registerNibWithClass:(Class)customClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(customClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(customClass)];
}
- (void)sy_registerCellWithClass:(Class)customClass {
    [self registerClass:customClass forCellReuseIdentifier:NSStringFromClass(customClass)];
}

#pragma mark - 注册SectionHeaderFooter
- (void)sy_registerNibForSectionHeaderFooterWithClass:(Class)customClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(customClass) bundle:nil]  forHeaderFooterViewReuseIdentifier:NSStringFromClass(customClass)];
}
- (void)sy_registerClassForSectionHeaderFooterWithClass:(Class)customClass {
    [self registerClass:customClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(customClass)];
}

@end

NSString *const SYTableViewContentOffsetChangeNotification = @"SYTableViewContentOffsetChangeNotification";
NSString *const SYTableViewContentOffsetChangeEndNotification = @"SYTableViewContentOffsetChangeEndNotification";

