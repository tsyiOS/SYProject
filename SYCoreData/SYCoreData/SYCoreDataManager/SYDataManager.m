//
//  SYDataManager.m
//  SYCoreData
//
//  Created by leju_esf on 16/8/18.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYDataManager.h"

/// 模型文件名
static NSString *const modelName = @"SYCoreData";
/// 数据库文件名
static NSString *const dbName = @"SYCoreData.db";

@interface SYDataManager ()
/**
 *  后台上下文
 */
@property (nonatomic) NSManagedObjectContext *backgroundMOC;
@end

@implementation SYDataManager

@synthesize managedObjectContext = _managedObjectContext;

SYSingleton_implementation(SYDataManager)

- (instancetype)init {
    self = [super init];
    if (self) {
        [self managedObjectContext];
    }
    return self;
}

#pragma mark - Core Data 设置
- (NSManagedObjectContext *)managedObjectContext {
    
    // 懒加载，返回已经绑定到 `数据库 persistent store coordinator(底层的数据库)` 的管理对象上下文
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    // 1. 创建模型的 URL，momd是在 bundle 中编译后的二进制包的扩展名
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    
    // 使用 URL 创建管理对象模型
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // 2. 创建 数据库 -> 传入对象模型，知道创建什么样的数据表
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    
    // 获得文档目录的 URL
    NSURL *docURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    // 建立数据库的完整 URL
    NSURL *storeURL = [docURL URLByAppendingPathComponent:dbName];
    
    // 创建数据库 - 传入指定的数据库 URL，创建数据库
    // 如果成功，返回存储对象，如果失败，返回 nil
    if ([psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil] == nil) {
        NSLog(@"创建数据库失败！返回空的上下文对象！");
        return nil;
    }
    
    // 3. 创建管理对象上下文 - 指定相关数据操作队列的类型
    /**
     NSPrivateQueueConcurrencyType		= 0x01,     私有队列 -> 自定义队列，使用后台线程做数据操作
     NSMainQueueConcurrencyType			= 0x02      主队列 -> 主线程进行数据操作
     */
    // 1> 实例化后台上下文
    _backgroundMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    // 2> 指定操作的数据库
    [_backgroundMOC setPersistentStoreCoordinator:psc];
    
    // 3> 实例化主线程上下文
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 4> 设置主线程上下文的 `父` 上下文
    [_managedObjectContext setParentContext:_backgroundMOC];
    
    return _managedObjectContext;
}

/// 保存上下文
- (BOOL)saveContext {
    
    // 判断上下文是否为 nil
    if (self.managedObjectContext == nil || self.backgroundMOC == nil) {
        NSLog(@"上下文为nil，无法进行数据操作");
        return NO;
    }
    
    // 判断是否有数据变化
    if (!self.managedObjectContext.hasChanges && !self.backgroundMOC.hasChanges) {
        NSLog(@"没有需要保存的数据");
        return YES;
    }
    
    // 进行保存数据
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"保存数据失败 -> %@", error);
        
        return NO;
    }
    
    NSLog(@"主线程保存完毕");
    // 在后台上下文保存数据
    [self.backgroundMOC save:NULL];
    
    return YES;
}


@end
