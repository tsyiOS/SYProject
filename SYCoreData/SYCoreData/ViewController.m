//
//  ViewController.m
//  SYCoreData
//
//  Created by leju_esf on 16/8/18.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYDataManager.h"
#import "SYFood.h"
#import "LJFood.h"
#import "Dog.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textView;

@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)insertData {
//    SYDataManager *dataManager = [SYDataManager sharedSYDataManager];
//    NSMutableArray *tempArray = [NSMutableArray array];
//    for (int i = 0; i < 5; i++) {
//        SYFood *food = [[SYFood alloc] init];
//        food.price = [NSNumber numberWithInteger:(i+1)*10];
//        food.name = [NSString stringWithFormat:@"菜-%d",i];
//        [tempArray addObject:food];
//    }
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 10000; i++) {
        LJFood *food = [NSEntityDescription insertNewObjectForEntityForName:@"LJFood" inManagedObjectContext:[SYDataManager sharedSYDataManager].managedObjectContext];
        Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:[SYDataManager sharedSYDataManager].managedObjectContext];
        dog.name = [@"旺财" stringByAppendingString:[NSString stringWithFormat:@"-%d",i]];
        dog.age = @10;
        food.name =[@"菜" stringByAppendingString:[NSString stringWithFormat:@"-%d",i]];;
        food.price = @15;
        food.dog = dog;
    }
    [[SYDataManager sharedSYDataManager] saveContext];
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"---%f",end - start);
}

- (IBAction)readData {
//    NSArray *foods = [[SYDataManager sharedSYDataManager] selectData:0 andOffset:0];
//    for (LJFood *food in foods) {
//        NSLog(@"%@",food.name);
//    }
}

@end
