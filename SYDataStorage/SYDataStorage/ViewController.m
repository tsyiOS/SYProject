//
//  ViewController.m
//  SYDataStorage
//
//  Created by leju_esf on 16/11/4.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"

#import "SYCacheExtension/SYCacheManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    NSDictionary *dict = [SYModel propretyList];
    SYModel *model = [[SYModel alloc] init];
    model.score = 100;
    model.cgfloat = 10.5;
    model.age = 18;
    model.charDefault = '9';
    model.obj = [[NSObject alloc] init];
    model.date = [NSDate date];
    model.dict = @{@"成功":@"haode "};
    model.attri = [[NSAttributedString alloc] initWithString:@"好的"];
    Student *stu = [[Student alloc] init];
    stu.name = @"张三";
    stu.age = 19;
    stu.weight = 160.5;
    model.stu = stu;
    NSLog(@"----%@",model.sy_keyValues);
    NSDictionary *dict = model.sy_keyValues;
    SYModel *newmodel = [SYModel sy_objectWithKeyValueDictionary:dict];
    NSLog(@"%@---%zd",newmodel.stu.name,newmodel.stu.age);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
