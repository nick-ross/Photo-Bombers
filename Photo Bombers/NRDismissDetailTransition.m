//
//  NRDismissDetailTransition.m
//  Photo Bombers
//
//  Created by Nick Ross on 7/1/14.
//  Copyright (c) 2014 Nick Ross. All rights reserved.
//

#import "NRDismissDetailTransition.h"

@implementation NRDismissDetailTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    detail.view.alpha = 0.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        detail.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [detail.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
