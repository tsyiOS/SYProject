//
//  RTHChatCell.h
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/10/8.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTHChatMessage.h"

@interface RTHChatCell : UITableViewCell

@property (nonatomic, strong) RTHChatMessage *message;
@end
