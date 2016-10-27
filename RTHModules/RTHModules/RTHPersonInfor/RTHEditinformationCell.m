//
//  RTHEditinformationCell.m
//  儒思HR
//
//  Created by yjc on 16/10/27.
//  Copyright © 2016年 Yala. All rights reserved.
//

#import "RTHEditinformationCell.h"

@interface RTHEditinformationCell ()

@end

@implementation RTHEditinformationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         [self setUpUI];
    }
    return self;
}


- (void)setUpUI {
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.rightImage];
    [self.leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.center.equalTo(self);
    }];
    [self.rightImage makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.top.equalTo(15);
        make.size.equalTo(CGSizeMake(20, 20));
        //make.center.equalTo(self);
    }];

    [self.rightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImage).offset(-30);
        make.top.equalTo(15);
    }];
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.font = [UIFont systemFontOfSize:16];
        _leftLabel.textColor = [UIColor grayColor];
    }
    return _leftLabel;
}
- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.font = [UIFont systemFontOfSize:13];
        _rightLabel.textColor = [UIColor lightGrayColor];
    }
    return _rightLabel;
}
- (UIImageView *)rightImage {
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]init];
        _rightImage.image = [UIImage imageNamed:@"图层-8-拷贝"];
    }
    return _rightImage;
}
@end
