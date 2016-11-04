//
//  SYDataManager+LJFood.m
//  SYCoreData
//
//  Created by leju_esf on 16/8/22.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYDataManager+LJFood.h"
#import "SYFood.h"
#import "LJFood.h"
#import "NSObject+SYExtension.h"

@implementation SYDataManager (LJFood)
- (void)insertCoreData:(NSArray *)dataArray WithEntityName:(NSString *)entityName{
    for (SYFood *food in dataArray) {
        NSManagedObject *newFood = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
        for (NSString *key in [SYFood sy_propertyList]) {
            if (![key isEqualToString:sy_keyForClassName]) {
                [newFood setValue:[food valueForKey:key] forKey:key];
            }
        }
    }
    
    [self saveContext];
}

- (NSArray *)selectData:(NSInteger)pageSize andOffset:(NSInteger)currentPage {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.fetchLimit = 10;
    fetchRequest.fetchOffset = 1;
    
    NSEntityDescription *entity = [NSEntityDescription  entityForName:NSStringFromClass([LJFood class]) inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    
    NSError *error = nil;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return objects;
}

- (void)deleteData {
    
}

- (void)updateData:(NSString *)mewsId withIsLook:(NSString *)isLook {
    
}

@end
