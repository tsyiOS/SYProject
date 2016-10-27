//
//  SYHeaderRefreshView.h
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/6/21.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SYRefreshStatus) {
    SYRefreshPullDown,
    SYRefreshReady,
    SYRefreshing
};

@interface SYHeaderRefreshView : UIView
@property (nonatomic, assign) SYRefreshStatus status;
@end
