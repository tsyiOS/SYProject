//
//  ViewController.m
//  SYHrefLabel
//
//  Created by leju_esf on 2017/9/5.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import "ViewController.h"
#import "SYHrefLabel.h"
#import "UIColor+SYExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *tip = [[UIView alloc] initWithFrame:CGRectMake(18, 30, self.view.bounds.size.width - 36, 50)];
    tip.backgroundColor = [UIColor sy_colorWithRGB:0xF9EEDF];
    tip.layer.borderColor = [UIColor sy_colorWithRGB:0xF3AB6D].CGColor;
    tip.layer.borderWidth = 0.5;
    tip.layer.cornerRadius = 3;
    tip.clipsToBounds = YES;
    
    SYHrefLabel *label = [[SYHrefLabel alloc] initWithFrame:CGRectMake(40, 10, tip.frame.size.width - 50, tip.frame.size.height)];
    label.backgroundColor = [UIColor sy_colorWithRGB:0xF9EEDF];
    
    ERAttributedStringModel *model = [[ERAttributedStringModel alloc] initWithFont:[UIFont systemFontOfSize:12] Color:[UIColor redColor] String:@"您的金币不足无法支付，您可以购买"];
    ERAttributedStringModel *href = [[ERAttributedStringModel alloc] initWithFont:[UIFont systemFontOfSize:12] Color:[UIColor sy_colorWithRGB:0x478CE0] String:@"拍摄服务" hadUnderLine:YES];
    [href setHrefAction:^{
        NSLog(@"点击拍摄服务");
    }];
    ERAttributedStringModel *model2 = [[ERAttributedStringModel alloc] initWithFont:[UIFont systemFontOfSize:12] Color:[UIColor redColor] String:@"专业的拍摄团队助您上小区首页 或"];
    ERAttributedStringModel *href2 = [[ERAttributedStringModel alloc] initWithFont:[UIFont systemFontOfSize:12] Color:[UIColor sy_colorWithRGB:0x478CE0] String:@"马上去充值" hadUnderLine:YES];
    [href2 setHrefAction:^{
        NSLog(@"点击去充值");
    }];
    
    
    [tip addSubview:label];
    [self.view addSubview:tip];
    
    label.models = @[model,href,model2,href2];
    
}


@end
