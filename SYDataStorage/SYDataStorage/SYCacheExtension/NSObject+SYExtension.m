//
//  NSObject+SYExtension.m
//
//  Created by 唐绍禹 on 16/8/10.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "NSObject+SYExtension.h"
#import <objc/runtime.h>
#import <CoreData/CoreData.h>
#import "NSArray+SYExtension.h"
#import "SYCoder.h"

#define SYPropertyType_Bool @"B"
#define SYPropertyType_char @"c"
#define SYPropertyType_int @"i"
#define SYPropertyType_float @"f"
#define SYPropertyType_double @"d"
#define SYPropertyType_NSInteger @"q"
#define SYPropertyType_Blcok @"@?"
#define SYPropertyType_id @"@"

static NSSet *foundationClasses_;

@implementation NSObject (SYExtension)
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [[[self class] alloc] init]) {
        Class c = self.class;
        while (c && c != [NSObject class]) {
            unsigned int count = 0;
            Ivar *ivar = class_copyIvarList(c, &count);
            for (int i = 0; i<count; i++) {
                Ivar iva = ivar[i];
                const char *name = ivar_getName(iva);
                NSString *strName = [NSString stringWithUTF8String:name];
                id value = [decoder decodeObjectForKey:strName];
                [self setValue:value forKey:strName];
            }
            free(ivar);
            c = [c superclass];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    Class c = self.class;
    while (c && c != [NSObject class]) {
        unsigned int count;
        Ivar *ivar = class_copyIvarList(c, &count);
        for (int i=0; i<count; i++) {
            Ivar iv = ivar[i];
            const char *name = ivar_getName(iv);
            NSString *strName = [NSString stringWithUTF8String:name];
            id value = [self valueForKey:strName];
            [encoder encodeObject:value forKey:strName];
        }
        free(ivar);
        c = [c superclass];
    }
}

- (id)sy_keyValues {
    if ([[self class] sy_isClassFromFoundation]) {
        return self;
    }
    //数组
    if ([self isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)self;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (id value in array) {
            [tempArray addObject:[value sy_keyValues]];
        }
        return tempArray;
    }
    //对象
//    NSArray *keys = [[self class] sy_propertyList];
    NSDictionary *keyTypes = [[self class] sy_propertyAndClassTypeDictionary];
    
    NSMutableDictionary *keyValues = [NSMutableDictionary dictionary];
    for (NSString *key in keyTypes.allKeys) {
        id value = [self valueForKey:key];
        //如何在此处崩溃，请查看属性修饰是否正确
        
        if ([[value class] sy_isClassFromFoundation] || [[self class] sy_baseData:[keyTypes objectForKey:key]]) {
            [keyValues setValue:value forKey:key];
        }else {
            [keyValues setValue: [value sy_keyValues] forKey:key];
        }
    }
//    [keyValues setValue:NSStringFromClass([self class]) forKey:sy_keyForClassName];
    return keyValues;
}

+ (instancetype)sy_objectWithKeyValueDictionary:(NSDictionary *)keyValues {
    NSDictionary *keyTypes = [[self class] sy_propertyAndClassTypeDictionary];
    id model = [[self alloc] init];
    for (NSString *key in keyTypes.allKeys) {
        if (![keyValues.allKeys containsObject:key]) {
            continue;
        }
        id value = keyValues[key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            Class c = NSClassFromString([keyTypes objectForKey:key]);
            id propretyModel = [c sy_objectWithKeyValueDictionary:value];
            [model setValue:propretyModel forKey:key];
        }else if ([value isKindOfClass:[NSArray class]]) {
            NSArray *valueArray = (NSArray *)value;
            NSMutableArray *tempArray = [NSMutableArray array];
            if ([[self sy_classNameInArrayProperty].allKeys containsObject:key]) {
                for (NSDictionary *dict in valueArray) {
                    Class c = NSClassFromString(value[[[self sy_classNameInArrayProperty] objectForKey:key]]);
                    id propretyModel = [c sy_objectWithKeyValueDictionary:dict];
                    [tempArray addObject:propretyModel];
                }
                [model setValue:tempArray forKey:key];
            }
        }else {
             [model setValue:value forKey:key];
        }
    }
    return model;
}

- (id)sy_objectWithKeyValue {
    if ([self isKindOfClass:[NSDictionary class]]) {
        NSDictionary *keyValue = (NSDictionary *)self;
        Class c = NSClassFromString(keyValue[sy_keyForClassName]);
        return [c sy_objectWithKeyValueDictionary:keyValue];
    }else {
        return nil;
    }
    
}

+ (NSDictionary *)sy_propertyAndClassTypeDictionary {
    Class c = self;
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivar = class_copyIvarList(c, &count);
        for (int i = 0; i<count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            const char *type = ivar_getTypeEncoding(iva);
            NSString *typeStr = [NSString stringWithUTF8String:type];
            NSString *nameStr = [NSString stringWithUTF8String:name];
            NSString *key = [nameStr substringFromIndex:1];
            if (![typeStr isEqualToString:SYPropertyType_id]&&![typeStr hasPrefix:SYPropertyType_Blcok]) {
                if ([typeStr hasPrefix:@"@\"NS"]) {
                    [mutableDict setObject:[typeStr substringWithRange:NSMakeRange(2, typeStr.length - 3)] forKey:key];
                }else if ([self sy_baseData:typeStr]){
                    [mutableDict setObject:typeStr forKey:key];
                }
                else if ([typeStr hasPrefix:@"@\""]){
                    if (![typeStr hasPrefix:@"@\"UI"] && ![typeStr hasPrefix:@"@\"AV"]) {
                        [mutableDict setObject:[typeStr substringWithRange:NSMakeRange(2, typeStr.length - 3)] forKey:key];
                    }
                }
            }
        }
        free(ivar);
        c = [c superclass];
    }
    return mutableDict.copy;
}

+ (NSArray *)sy_propertyList {
    return [self sy_propertyAndClassTypeDictionary].allKeys;
}

+ (NSSet *)sy_foundationClasses {
    if (foundationClasses_ == nil) {
        // 集合中没有NSObject，因为几乎所有的类都是继承自NSObject，具体是不是NSObject需要特殊判断
        foundationClasses_ = [NSSet setWithObjects:
                              [NSURL class],
                              [NSDate class],
                              [NSValue class],
                              [NSData class],
                              [NSError class],
//                              [NSArray class],
                              [NSDictionary class],
                              [NSString class],
                              [NSAttributedString class], nil];
    }
    return foundationClasses_;
}

+ (BOOL)sy_isClassFromFoundation {
    if (self == [NSObject class] || self == [NSManagedObject class]) return YES;
    
    __block BOOL result = NO;
    [[self sy_foundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        if ([self isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

+ (BOOL)sy_baseData:(NSString *)type {
    return [@[SYPropertyType_char,SYPropertyType_Bool,SYPropertyType_int,SYPropertyType_float,SYPropertyType_double,SYPropertyType_NSInteger] containsObject:type];
}
@end

NSString *const sy_keyForClassName = @"keyForClassName";
