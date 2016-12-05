//
//  ViewController.m
//  SYScanLife
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYScanLifeViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

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

- (IBAction)scanLife {
    SYScanLifeViewController *scanVC = [[SYScanLifeViewController alloc] init];
   // scanVC.type = SYScanTypeBarCode;
    [scanVC setFinishedScan:^(NSString *str) {
        self.resultLabel.text = str;
    }];
    [self.navigationController presentViewController:scanVC animated:YES completion:nil];
}
@end
