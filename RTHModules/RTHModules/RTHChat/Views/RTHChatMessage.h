//
//  RTHChatMessage.h
//  SYSlideDemo
//
//  Created by leju_esf on 16/10/9.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTHChatMessage : NSObject
@property (nonatomic, copy) NSAttributedString *message;
@property (nonatomic, copy) NSString *headImageUrl;
@property (nonatomic, assign) BOOL isMyself;
@end
