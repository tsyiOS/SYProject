
#import <UIKit/UIKit.h>

@interface UITableView (SYExtension)

@property (nonatomic, copy) void (^sy_headerRefresh)();

- (void)sy_beginRefresh;
- (void)sy_endRefresh;
- (void)sy_observeTableViewContentOffset;

#pragma mark - 注册cell
/**
 *  注册自定义cell(有xib)
 *
 *  @param customClass 类名
 */
- (void)sy_registerNibWithClass:(Class)customClass;
/**
 *  注册自定义cell(无xib)
 *
 *  @param customClass 类名
 */
- (void)sy_registerCellWithClass:(Class)customClass;

#pragma mark - 注册SectionHeaderFooter
/**
 *  注册自定义header footer (有xib)
 *
 *  @param customClass 类名
 */
- (void)sy_registerNibForSectionHeaderFooterWithClass:(Class)customClass;
/**
 *  注册自定义header footer (无xib)
 *
 *  @param customClass 类名
 */
- (void)sy_registerClassForSectionHeaderFooterWithClass:(Class)customClass;
@end

#pragma mark - tableView的ContentOffset改变的时候的通知 如想监听此通知须调用方法sy_observeTableViewContentOffset
/**
 *  tableview contentOffset 改变的时候的通知
 */
extern NSString *const SYTableViewContentOffsetChangeNotification;
/**
 *  tableview contentOffset 改变结束时候的通知
 */
extern NSString *const SYTableViewContentOffsetChangeEndNotification;
