//
//  RTHEditinformationFooterVIew.m
//  儒思HR
//
//  Created by yjc on 16/10/27.
//  Copyright © 2016年 Yala. All rights reserved.
//

#import "RTHEditinformationFooterVIew.h"

@interface RTHEditinformationFooterVIew ()
@property (nonatomic ,strong)UILabel *uploadLabel;
@property (nonatomic ,strong)UILabel *rusiLabel;
@property (nonatomic ,strong)UIButton *agreeBtn;
@property (nonatomic ,strong)UIButton *commitBtn;
@end
@implementation RTHEditinformationFooterVIew
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    [self addSubview:self.uploadLabel];
    [self addSubview:self.rusiLabel];
    [self addSubview:self.agreeBtn];
    [self addSubview:self.commitBtn];
    
    [self.uploadLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        
    }];
    [self.agreeBtn makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
}
-(UIButton *)agreeBtn {
    if (!_agreeBtn) {
        _agreeBtn = [[UIButton alloc]init];
        _agreeBtn.imageView.image= [UIImage imageNamed:@"bofangjindu"];
        _agreeBtn.titleLabel.text = @"同意";
        _agreeBtn.tintColor = [UIColor grayColor];
        
    }
    return _agreeBtn;
}
- (UILabel *)uploadLabel {
    if (!_uploadLabel) {
        _uploadLabel = [[UILabel alloc]init];
        _uploadLabel.text = @"请上传你的照片和简历";
        _uploadLabel.font = [UIFont systemFontOfSize:13];
        _uploadLabel.textColor = [UIColor grayColor];
    }
    return _uploadLabel;
}
- (UILabel *)rusiLabel {
    if (!_rusiLabel) {
        _rusiLabel = [[UILabel alloc]init];
        _rusiLabel.text = @"<<儒思协议>>";
        _rusiLabel.font = [UIFont systemFontOfSize:13];
       
    }
    return _rusiLabel;
}


@end
