//
//  RTHPictureDisplayView.h
//  SYImagePicker
//
//  Created by 唐绍禹 on 16/10/25.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RTHPictuerDisplayType) {
    /**
     *  发布状态
     */
    RTHPictuerDisplayTypePublish,
    /**
     *  普通展示
     */
    RTHPictuerDisplayTypeNormal
};

@interface RTHPictureDisplayView : UIView
/**
 *  添加照片
 */
@property (nonatomic, copy) void (^addPcitureAction)();
/**
 *  拍照
 */
@property (nonatomic, copy) void (^takePhotoAction)();
/**
 *  数据源
 */
@property (nonatomic, strong) NSArray *images;
/**
 *  最大张数
 */
@property (nonatomic, assign) NSInteger maxCount;
/**
 *  实例化方法
 *
 *  @param frame 大小
 *  @param type  类型
 *
 *  @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame andType:(RTHPictuerDisplayType) type;
@end

@interface RTHPictureItem : UIView
@property (nonatomic, copy) void (^deleateItem)();
@property (nonatomic, copy) void (^clickAction)();
- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image isAddBtn:(BOOL)add;
@end
