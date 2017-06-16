//
//  SYModel.m
//  SYDataStorage
//
//  Created by leju_esf on 2017/6/16.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import "SYModel.h"
#import <objc/runtime.h>



@implementation Student


@end

@implementation SYModel

//+ (NSDictionary *)propretyList {
//    Class c = self;
//    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
//    while (c && c != [NSObject class]) {
//        unsigned int count = 0;
//        Ivar *ivar = class_copyIvarList(c, &count);
//        for (int i = 0; i<count; i++) {
//            Ivar iva = ivar[i];
//            const char *name = ivar_getName(iva);
//            const char *type = ivar_getTypeEncoding(iva);
//            NSString *typeStr = [NSString stringWithUTF8String:type];
//            NSString *nameStr = [NSString stringWithUTF8String:name];
//            NSString *key = [nameStr substringFromIndex:1];
//            if (![typeStr isEqualToString:SYPropertyType_id]&&![typeStr hasPrefix:SYPropertyType_Blcok]) {
//                if ([typeStr hasPrefix:@"@\"NS"]) {
//                    [mutableDict setObject:[typeStr substringWithRange:NSMakeRange(2, typeStr.length - 3)] forKey:key];
//                }else if ([self sy_baseData:typeStr]){
//                    [mutableDict setObject:typeStr forKey:key];
//                }
//                else if ([typeStr hasPrefix:@"@\""]){
//                    if (![typeStr hasPrefix:@"@\"UI"] && ![typeStr hasPrefix:@"@\"AV"]) {
//                        [mutableDict setObject:[typeStr substringWithRange:NSMakeRange(2, typeStr.length - 3)] forKey:key];
//                    }
//                }
//            }
//        }
//        free(ivar);
//        c = [c superclass];
//    }
//    return mutableDict.copy;
//}
//
//+ (BOOL)sy_baseData:(NSString *)type {
//    return [@[SYPropertyType_char,SYPropertyType_Bool,SYPropertyType_int,SYPropertyType_float,SYPropertyType_double,SYPropertyType_NSInteger] containsObject:type];
//}

@end
