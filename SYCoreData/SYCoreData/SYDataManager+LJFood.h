//
//  SYDataManager+LJFood.h
//  SYCoreData
//
//  Created by leju_esf on 16/8/22.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYDataManager.h"

@interface SYDataManager (LJFood)
- (void)insertCoreData:(NSArray *)dataArray WithEntityName:(NSString *)entityName;
- (NSArray *)selectData:(NSInteger)pageSize andOffset:(NSInteger)currentPage;
- (void)deleteData;
- (void)updateData:(NSString *)mewsId withIsLook:(NSString *)isLook;
@end
