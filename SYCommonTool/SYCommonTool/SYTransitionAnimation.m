//
//  SYTransitionAnimation.m
//  SYCommonTool
//
//  Created by leju_esf on 2018/4/17.
//  Copyright © 2018年 tsy. All rights reserved.
//

#import "SYTransitionAnimation.h"

@implementation SYTransitionAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.25;
    
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    toVc.view.frame = [UIScreen mainScreen].bounds;
    
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (self.animationType == SYAnimationTypePresent) {
        
        UIView * snap = [fromVc.view snapshotViewAfterScreenUpdates:YES];
        
        [transitionContext.containerView addSubview:snap];
        
        [transitionContext.containerView addSubview:self.shadow];
        
        UIView * snap2 = [toVc.view snapshotViewAfterScreenUpdates:YES];
        
        [transitionContext.containerView addSubview:snap2];
        
        snap2.transform = CGAffineTransformMakeTranslation(0,  [UIScreen mainScreen].bounds.size.height);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
            
            snap2.transform = CGAffineTransformIdentity;
            
            self.shadow.alpha = 0.3;
            
        } completion:^(BOOL finished) {
            
            [snap2 removeFromSuperview];
            
            [[transitionContext containerView] addSubview:toVc.view];
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
    }else {
        UIView * snap = [toVc.view snapshotViewAfterScreenUpdates:YES];
        
        [transitionContext.containerView addSubview:snap];
        
        [transitionContext.containerView addSubview:self.shadow];
        
        UIView * snap2 = [fromVc.view snapshotViewAfterScreenUpdates:YES];
        
        [transitionContext.containerView addSubview:snap2];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
            
            snap2.transform = CGAffineTransformMakeTranslation(0,  [UIScreen mainScreen].bounds.size.height);
            
            self.shadow.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [snap2 removeFromSuperview];
            
            [self.shadow removeFromSuperview];
            
            [[transitionContext containerView] addSubview:toVc.view];
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }
}

- (UIView *)shadow {
    
    if (_shadow == nil) {
        
        _shadow = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _shadow.backgroundColor = [UIColor blackColor];
        
        _shadow.alpha = 0;
    }
    return _shadow;
}
@end
