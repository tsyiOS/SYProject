//
//  SYModel.h
//  SYDataStorage
//
//  Created by leju_esf on 2017/6/16.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+SYExtension.h"

@interface Student : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) CGFloat weight;
@end

@interface SYModel : NSObject
@property(nonatomic, assign)int score;
@property(nonatomic,assign)CGFloat cgfloat ;
@property(nonatomic, assign)float   afloat;
@property(nonatomic,strong)Student *stu;
@property (nonatomic, assign) NSInteger age;
@property char charDefault;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, strong) NSObject *obj;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSAttributedString *attri;
@end
