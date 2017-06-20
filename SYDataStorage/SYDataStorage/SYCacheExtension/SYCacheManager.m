//
//  SYCacheManager.m
//  SYDataStorage
//
//  Created by leju_esf on 16/11/4.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYCacheManager.h"

@implementation SYCacheManager
SYSingleton_implementation(SYCacheManager)

- (instancetype)init {
    if (self == [super init]) {
        NSDictionary *propertyDict = [[self class] sy_propertyAndClassTypeDictionary];
        for (NSString *property in propertyDict.allKeys) {
            id value = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),property]];
            if (value != nil) {
                 [self setValue:value forKey:property];
            }
            [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        } 
    } 
    return self; 
} 
 
- (void)sy_clearData { 
    NSArray *propretyList = [[self class] sy_propertyList]; 
    for (NSString *proprety in propretyList) { 
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),proprety]]; 
    } 
} 
 
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context { 
    id value = [change objectForKey:@"new"]; 
    id keyValues = [value sy_keyValues];
    NSString *key = [NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),keyPath];
    [[NSUserDefaults standardUserDefaults] setValue:keyValues forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize]; 
}
@end
