//
//  SYDataManager.h
//  SYCoreData
//
//  Created by leju_esf on 16/8/18.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYCoder.h"
#import <CoreData/CoreData.h>

@interface SYDataManager : NSObject
SYSingleton_interface(SYDataManager)
@property (nonatomic, strong,readonly) NSManagedObjectContext *managedObjectContext;
- (BOOL)saveContext;
@end
