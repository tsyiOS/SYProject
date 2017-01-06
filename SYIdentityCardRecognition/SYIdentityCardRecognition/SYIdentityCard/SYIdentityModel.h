//
//  SYIdentityModel.h
//  SYIdentityCardRecognition
//
//  Created by leju_esf on 17/1/4.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYCoder.h"

@interface SYIdentityModel : NSObject
@property (nonatomic, assign) int type; //1:正面  2:反面
@property (nonatomic, copy) NSString *code; //身份证号
@property (nonatomic, copy) NSString *name; //姓名
@property (nonatomic, copy) NSString *gender; //性别
@property (nonatomic, copy) NSString *nation; //民族
@property (nonatomic, copy) NSString *address; //地址
@property (nonatomic, copy) NSString *issue; //签发机关
@property (nonatomic, copy) NSString *valid; //有效期
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *day;

- (BOOL)gathered;

+ (void)insertModel:(SYIdentityModel *)model;

SYStorageByArchive_interface(SYIdentityModel)
@end
