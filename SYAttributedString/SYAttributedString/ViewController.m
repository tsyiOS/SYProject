//
//  ViewController.m
//  SYAttributedString
//
//  Created by leju_esf on 16/10/21.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYAttributedStringModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        SYAttributedStringModel *model = [SYAttributedStringModel attributedStringModelWithFont:[UIFont systemFontOfSize:15] Color:@[[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor grayColor],[UIColor blackColor]][i] String:[NSString stringWithFormat:@"说什么呢+%d",i]];
        [tempArray addObject:model];
    }
    NSAttributedString *attStr = [SYAttributedStringModel sy_attributedStringWithModels:tempArray];
    self.label.attributedText = attStr;
    NSRange attStrRange = NSMakeRange(0, attStr.length);
    NSDictionary *dict = [attStr attributesAtIndex:0 effectiveRange:&attStrRange];
    NSLog(@"===%@",dict);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
