//
//  RTHEditInformationFooterView.m
//  RTHModules
//
//  Created by leju_esf on 16/10/27.
//  Copyright © 2016年 唐绍禹. All rights reserved.
//

#import "RTHEditInformationFooterView.h"

@implementation RTHEditInformationFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubview:self.displayView];
}

- (IBAction)agreeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)optionalAction {
    if (self.optionalBtnAction) {
        self.optionalBtnAction();
    }
}

- (IBAction)commit {
    if (self.bottomBtnAction) {
        self.bottomBtnAction();
    }
}

+ (instancetype)viewFromNib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}

- (RTHPictureDisplayView *)displayView {
    if (_displayView == nil) {
        _displayView = [[RTHPictureDisplayView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0) andType:RTHPictuerDisplayTypeEdit];
    }
    return _displayView;
}

@end
