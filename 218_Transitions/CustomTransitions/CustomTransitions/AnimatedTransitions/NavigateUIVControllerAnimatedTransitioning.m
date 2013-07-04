//
//  NavigateUIVControllerAnimatedTransitioning.m
//  CustomTransitions
//
//  Created by ding orlando on 7/2/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "NavigateUIVControllerAnimatedTransitioning.h"

@implementation NavigateUIVControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *inView = [transitionContext containerView];
    // UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //  UIView *fromView = [fromVC view];
    UIView *toView =  [toVC view];
    
    CGRect frameToView = toView.frame;
    toView.frame = CGRectMake(0, 0, 320, 160);
    [inView addSubview:toView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay: 5.0f
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                            toView.frame = frameToView;
                        }
                     completion:^(BOOL finished){
                            [transitionContext completeTransition:YES];
                        }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 5;
}


@end
