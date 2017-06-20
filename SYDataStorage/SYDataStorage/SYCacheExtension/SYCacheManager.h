//
//  SYCacheManager.h
//  SYDataStorage
//
//  Created by leju_esf on 16/11/4.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYCoder.h"
#import "SYModel.h"
/**
 只能保存NSUserdefault 能保存的对象
 */
@interface SYCacheManager : NSObject
SYSingleton_interface(SYCacheManager)

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL isOk;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, assign) float weight;

@end
