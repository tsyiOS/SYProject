//
//  SYIDCell.m
//  SYIdentityCardRecognition
//
//  Created by leju_esf on 17/1/6.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import "SYIDCell.h"
#import "SYAttributedStringModel.h"

@interface SYIDCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *nationLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation SYIDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SYIdentityModel *)model {
    self.nameLabel.text = model.name;
    self.sexLabel.text = model.gender;
    self.nationLabel.text = model.nation;
    self.addressLabel.text =  model.address;
    self.numberLabel.text = model.code;
    
    self.birthdayLabel.text = [NSString stringWithFormat:@""];
    
    if (model.code) {
        
        NSArray *strs = @[model.year,@" 年 ",model.month,@" 月 ",model.day,@" 日 "];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (int i = 0; i < strs.count; i++) {
            if (i%2 == 0) {
                SYAttributedStringModel *numModel = [SYAttributedStringModel attributedStringModelWithFont:[UIFont systemFontOfSize:15] Color:self.nameLabel.textColor String:strs[i]];
                [tempArray addObject:numModel];
            }else {
                SYAttributedStringModel *strModel = [SYAttributedStringModel attributedStringModelWithFont:[UIFont systemFontOfSize:13] Color:self.titleLabel.textColor String:strs[i]];
                [tempArray addObject:strModel];
            }
        }
        self.birthdayLabel.attributedText = [SYAttributedStringModel sy_attributedStringWithModels:tempArray];
    }
}

@end
