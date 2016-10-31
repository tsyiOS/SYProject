//
//  ERPullDownCell.m
//  ESFManager
//
//  Created by leju_esf on 16/6/12.
//  Copyright © 2016年 leju. All rights reserved.
//

#import "ERPullDownCell.h"

@interface ERPullDownCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLeftMargin;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@end

@implementation ERPullDownCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setChecked:(BOOL)checked {
    _checked = checked;
//    self.contentLabel.textColor = checked ? [UIColor appMainColor]:[UIColor textGrayColor];
//    self.bottomLine.backgroundColor = checked ? [UIColor appMainColor]:[UIColor lineDefaultColor];
    if (self.model.imageNameNormal.length > 0) {
        self.iconImageView.image = [UIImage imageNamed:checked?self.model.imageNameSelected:self.model.imageNameNormal];
    }
}

- (void)setModel:(ERPullDownModel *)model {
    _model = model;
    if (model.imageNameNormal.length > 0) {
        self.labelLeftMargin.constant = 37;
        self.iconImageView.hidden = NO;
        self.iconImageView.image = [UIImage imageNamed:model.imageNameNormal];
    }else {
        self.labelLeftMargin.constant = 0;
        self.iconImageView.hidden = YES;
    }
    self.contentLabel.text = model.title;
}

@end

@implementation ERPullDownModel


@end
