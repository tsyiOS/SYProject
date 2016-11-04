//
//  NSArray+SYExtension.h
//
//  Created by 唐绍禹 on 16/8/11.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SYExtension)
/**
 *  将模型数组通过plist存到本地
 */
- (void)sy_saveModelsByPlist;
/**
 *  将模型数组通过归档解档存到本地
 */
- (void)sy_saveModelsByArchive;
/**
 *  将字典数组通过plist存到本地
 */
- (void)sy_saveDictionarysByPlistWithFileName:(NSString *)fileName;
/**
 *  字典数组转模型数组（前提是通过sy_keyValues转换的字典，否则不能使用）
 *
 *  @return 模型数组
 */
- (NSArray *)sy_objectsWithKeyValues;
@end
