//
//  NSArray+SYExtension.m
//
//  Created by 唐绍禹 on 16/8/11.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "NSArray+SYExtension.h"
#import "NSObject+SYExtension.h"

@implementation NSArray (SYExtension)

- (void)sy_saveModelsByPlist {
    if (self.count > 0) {
        id firstModel = self.firstObject;
        NSString *filePath = [self dataPathWithFileName:[NSString stringWithFormat:@"%@.plist",NSStringFromClass([firstModel class])]];
        NSLog(@"plist=%@",filePath);
        NSArray *tempArray = [self sy_keyValues];
        [tempArray sy_writeToFile:filePath];
    }
}

- (void)sy_saveDictionarysByPlistWithFileName:(NSString *)fileName {
    if (self.count > 0) {
        NSString *filePath = [self dataPathWithFileName:[NSString stringWithFormat:@"%@.plist",fileName]];
        NSLog(@"plist=%@",filePath);
        [self sy_writeToFile:filePath];
    }
}

- (void)sy_writeToFile:(NSString *)filePath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    [self writeToFile:filePath atomically:YES];
}

- (void)sy_saveModelsByArchive {
    id firstModel = self.firstObject;
    NSString *filePath = [self dataPathWithFileName:[NSString stringWithFormat:@"%@.da",NSStringFromClass([firstModel class])]];
    NSLog(@"Archive=%@",filePath);
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
     [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}

- (NSString *)dataPathWithFileName:(NSString *)fileName {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject stringByAppendingPathComponent:fileName];
}

- (NSArray *)sy_objectsWithKeyValues {
    NSMutableArray *tempArray = [NSMutableArray array];
    NSArray *array = (NSArray *)self;
    for (id value in array) {
        if ([value isKindOfClass:[NSArray class]]) {
            [tempArray addObject:[value sy_objectsWithKeyValues]];
        }else if ([value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *keyValues = (NSDictionary *)value;
            Class c = NSClassFromString(keyValues[sy_keyForClassName]);
            id propretyModel = [c sy_objectWithKeyValueDictionary:value];
            [tempArray addObject:propretyModel];
        }else {
            [tempArray addObject:value];
        }
    }
    return tempArray;
}

@end
