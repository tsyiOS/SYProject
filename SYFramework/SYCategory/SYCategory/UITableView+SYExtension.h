
#import <UIKit/UIKit.h>

@interface UITableView (SYExtension)

@property (nonatomic, copy) void (^sy_headerRefresh)();

- (void)sy_beginRefresh;
- (void)sy_endRefresh;
- (void)sy_observeTableViewContentOffset;

#pragma mark - 注册cell
- (void)sy_registerNibWithClass:(Class)customClass;
- (void)sy_registerCellWithClass:(Class)customClass;

#pragma mark - 注册SectionHeaderFooter
- (void)sy_registerNibForSectionHeaderFooterWithClass:(Class)customClass;
- (void)sy_registerClassForSectionHeaderFooterWithClass:(Class)customClass;
@end

#pragma mark - tableView的ContentOffset改变的时候的通知
extern NSString *const SYTableViewContentOffsetChangeNotification;
extern NSString *const SYTableViewContentOffsetChangeEndNotification;
