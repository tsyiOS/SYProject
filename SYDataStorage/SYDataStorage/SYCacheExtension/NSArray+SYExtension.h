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
@end
