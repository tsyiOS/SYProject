//
//  SYCoder.h
//
//  Created by 唐绍禹 on 16/5/20.
//  Copyright © 2016年 tsy. All rights reserved.
//

#ifndef SYCoder_h
#define SYCoder_h

#import <objc/message.h>
#import <objc/runtime.h>
#import "NSObject+SYExtension.h"
#import "NSArray+SYExtension.h"

#pragma mark - 归档解档代码
/**********归档解档代码**********/
#define SYDecoderCoding \
- (id)initWithCoder:(NSCoder *)decoder {\
    if (self = [super init]) {\
        Class c = self.class;\
        while (c && c != [NSObject class]) {\
            unsigned int count = 0;\
            Ivar *ivar = class_copyIvarList(c, &count);\
            for (int i = 0; i<count; i++) {\
                Ivar iva = ivar[i];\
                const char *name = ivar_getName(iva);\
                NSString *strName = [NSString stringWithUTF8String:name];\
                id value = [decoder decodeObjectForKey:strName];\
                [self setValue:value forKey:strName];\
            }\
            free(ivar);\
            c = [c superclass];\
        }\
    }\
    return self;\
}\
\
- (void)encodeWithCoder:(NSCoder *)encoder {\
    Class c = self.class;\
    while (c && c != [NSObject class]) {\
        unsigned int count;\
        Ivar *ivar = class_copyIvarList(c, &count);\
        for (int i=0; i<count; i++) {\
            Ivar iv = ivar[i];\
            const char *name = ivar_getName(iv);\
            NSString *strName = [NSString stringWithUTF8String:name];\
            id value = [self valueForKey:strName];\
            [encoder encodeObject:value forKey:strName];\
        }\
        free(ivar);\
        c = [c superclass];\
    }\
}

#pragma mark - 归档解档存储
/**********归档解档存储**********/
//.h代码
#define SYStorageByArchive_interface(className)\
+ (NSArray *)sy_get##className##DataFormArchive;

//.m代码
#define SYStorageByArchive_implementation(className)\
SYDecoderCoding\
+ (NSArray *)sy_get##className##DataFormArchive {\
NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.da",NSStringFromClass(self)]];\
return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];\
}

#pragma mark - plist存储
/**********plist存储**********/
//.h代码
#define SYStorageByPlist_interface(className)\
+ (NSArray *)sy_get##className##DataFormPlist;

//.m代码
#define SYStorageByPlist_implementation(className)\
+ (NSArray *)sy_get##className##DataFormPlist {\
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",NSStringFromClass([self class])]];\
    NSArray *datas = [NSArray arrayWithContentsOfFile:filePath];\
    NSMutableArray *tempArray = [NSMutableArray array];\
    for (NSDictionary *dict in datas) {\
        id model = [self sy_objectWithKeyValueDictionary:dict];\
        [tempArray addObject:model];\
    }\
    return tempArray;\
}\
\
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

#pragma mark - 单例
/**********单例**********/
//单例.h代码
#define SYSingleton_interface(className) \
+(instancetype)shared##className;
//单例.m代码
#define SYSingleton_implementation(className)\
static id instance;\
+(instancetype)shared##className {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [[self alloc] init];\
});\
return instance;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [super allocWithZone:zone];\
});\
return instance;\
}

#pragma mark - 用户模型单例时时存储
/**********用户模型单例时时存储**********/
//单例.h代码
#define SYUserDefaultSingleton_interface(className)\
SYSingleton_interface(className)\
- (void)sy_clearData;
//单例.m代码
#define SYUserDefaultSingleton_implementation(className)\
SYSingleton_implementation(className)\
\
- (instancetype)init {\
    if (self == [super init]) {\
        NSArray *propretyList = [[self class] sy_propertyList];\
        for (NSString *proprety in propretyList) {\
            id value = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),proprety]];\
            if ([value isKindOfClass:[NSArray class]]) {\
                [self setValue:[value sy_objectsWithKeyValues] forKey:proprety];\
            }else if ([value isKindOfClass:[NSDictionary class]]) {\
                [self setValue:[value sy_objectWithKeyValue] forKey:proprety];\
            }else {\
                [self setValue:value forKey:proprety];\
            }\
            [self addObserver:self forKeyPath:proprety options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];\
        }\
    }\
    return self;\
}\
\
- (void)sy_clearData {\
    NSArray *propretyList = [[self class] sy_propertyList];\
    for (NSString *proprety in propretyList) {\
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),proprety]];\
    }\
}\
\
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {\
    id value = [change objectForKey:@"new"];\
    id keyValues = [value sy_keyValues];\
    [[NSUserDefaults standardUserDefaults] setValue:keyValues forKey:[NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),keyPath]];\
    [[NSUserDefaults standardUserDefaults] synchronize];\
}

#endif /* SYCoder_h */
