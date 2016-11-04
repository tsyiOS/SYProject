//
//  Dog+CoreDataProperties.h
//  SYCoreData
//
//  Created by leju_esf on 16/8/22.
//  Copyright © 2016年 tsy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Dog.h"

NS_ASSUME_NONNULL_BEGIN

@interface Dog (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
