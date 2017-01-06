//
//  SYIdentityModel.m
//  SYIdentityCardRecognition
//
//  Created by leju_esf on 17/1/4.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import "SYIdentityModel.h"

@implementation SYIdentityModel
SYStorageByArchive_implementation(SYIdentityModel)

+ (void)insertModel:(SYIdentityModel *)model {
    NSMutableArray *locationCache = [NSMutableArray arrayWithArray:[self sy_getSYIdentityModelDataFormArchive]];
    for (SYIdentityModel *cacheModel in locationCache) {
        if ([model.code isEqualToString:cacheModel.code]) {
            [locationCache removeObject:cacheModel];
            [locationCache addObject:model];
            [locationCache sy_saveModelsByArchive];
            return;
        }
    }
    [locationCache addObject:model];
    [locationCache sy_saveModelsByArchive];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@--%@--%@--%@--%@--%@--%@--%d",self.code,self.name,self.gender,self.nation,self.address,self.issue,self.valid,self.type];
}

- (BOOL)gathered {
    if (self.type == 1) {
        return self.code&&self.name&&self.gender&&self.nation&&self.address;
    }else {
        return self.issue&&self.valid;
    }
}

- (NSString *)year {
    if (self.code) {
        return [self.code substringWithRange:NSMakeRange(6, 4)];
    }else {
        return nil;
    }
}

- (NSString *)month {
    if (self.code) {
        return [self.code substringWithRange:NSMakeRange(10, 2)];
    }else {
        return nil;
    }
}

- (NSString *)day {
    if (self.code) {
        return [self.code substringWithRange:NSMakeRange(12, 2)];
    }else {
        return nil;
    }
}
@end
