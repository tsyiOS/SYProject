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
        NSArray *propretyList = [[self class] sy_propertyList];
        for (NSString *proprety in propretyList) { 
            id value = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),proprety]]; 
            if ([value isKindOfClass:[NSArray class]]) { 
//                [self setValue:[value sy_objectsWithKeyValues] forKey:proprety]; 
            }else if ([value isKindOfClass:[NSDictionary class]]) { 
                [self setValue:[value sy_objectWithKeyValue] forKey:proprety]; 
            }else { 
                [self setValue:value forKey:proprety]; 
            } 
            [self addObserver:self forKeyPath:proprety options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL]; 
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
    [[NSUserDefaults standardUserDefaults] setValue:keyValues forKey:[NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),keyPath]]; 
    [[NSUserDefaults standardUserDefaults] synchronize]; 
}
@end
