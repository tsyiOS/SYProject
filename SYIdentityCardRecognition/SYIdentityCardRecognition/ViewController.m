//
//  ViewController.m
//  SYIdentityCardRecognition
//
//  Created by leju_esf on 17/1/4.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYIDCardRecogintViewController.h"

@interface ViewController ()

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

- (IBAction)scanIdentityCard:(id)sender {
    SYIDCardRecogintViewController *scanVC = [[SYIDCardRecogintViewController alloc] init];

    [self.navigationController presentViewController:scanVC animated:YES completion:nil];
}

- (IBAction)recognitIdentityCard {
    
}
@end
