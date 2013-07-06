//
//  NavigatedTransitionController.m
//  CustomTransitions
//
//  Created by ding orlando on 7/4/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "NavigatedTransitionController.h"

@implementation NavigatedTransitionController

#pragma mark - source code template

- (void)template_animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    [[[transitionContext containerView] layer] setSublayerTransform:template_perspectiveTransform()];
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    
    toVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    toVC.view.layer.transform = CATransform3DMakeRotation(-M_PI_2,0.0,1.0,0.0); //flip halfway
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         fromVC.view.layer.transform = CATransform3DMakeRotation(M_PI_2,0.0,1.0,0.0); //flip halfway
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0f
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              toVC.view.layer.transform = CATransform3DMakeRotation(0.0f,0.0,1.0,0.0); //finish the flip
                                          } completion:^(BOOL finished){
                                              [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                                          }];
                     }];
}

CATransform3D template_perspectiveTransform() {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500;
    return transform;
}

#pragma mark - spring and slide effect implementations

- (void)spring:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    toVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0f
                          delay:0.0f
         usingSpringWithDamping:0.2f
          initialSpringVelocity:2.4f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                              toVC.view.center = [transitionContext containerView].center;
                          }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

- (void)slide:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    toVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
//                         toVC.view.center = [transitionContext containerView].center;
                     }
                     completion:^(BOOL finished){
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [self slide:transitionContext];
//    [self spring:transitionContext];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

@end
