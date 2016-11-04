//
//  LJFood+CoreDataProperties.h
//  SYCoreData
//
//  Created by leju_esf on 16/8/22.
//  Copyright © 2016年 tsy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LJFood.h"

NS_ASSUME_NONNULL_BEGIN

@interface LJFood (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSManagedObject *dog;

@end

NS_ASSUME_NONNULL_END
