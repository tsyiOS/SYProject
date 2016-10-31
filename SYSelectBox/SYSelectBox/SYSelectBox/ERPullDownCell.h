//
//  ERPullDownCell.h
//  ESFManager
//
//  Created by leju_esf on 16/6/12.
//  Copyright © 2016年 leju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ERPullDownModel;
@interface ERPullDownCell : UITableViewCell
@property (nonatomic, strong) ERPullDownModel *model;
@property (nonatomic, assign) BOOL checked;
@end

@interface ERPullDownModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageNameNormal;
@property (nonatomic, copy) NSString *imageNameSelected;
@end