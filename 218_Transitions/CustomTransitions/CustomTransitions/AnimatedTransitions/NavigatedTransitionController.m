//
//  NavigatedTransitionController.m
//  CustomTransitions
//
//  Created by ding orlando on 7/4/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "NavigatedTransitionController.h"

#define IS_IOS7_DP2 0

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

#if IS_IOS7_DP2

/**
 *see http://www.makebetterthings.com/iphone/check-ios-version-and-write-conditional-code/
 *see http://stackoverflow.com/questions/820142/how-to-target-a-specific-iphone-version
 **/
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

#endif

/**
 * see https://devforums.apple.com/message/835530#835530
 *  1, slide edge effect - follow-ups: (customized pop-up, preseted VC)
 *  top - (0, -height)
 *  left - (-width, 0)
 *  bottom - (0, height)
 *  right - (width, 0)
 *  top-right - (width, -height)
 *  top-left - (-width, -height)
 *  bottom-right - (width, height)
 *  bottom-left - (0, height)
 *  2, bottom empty area - how-to fill it?
 **/
- (void)slide:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    float _fHeight = [transitionContext containerView].frame.size.height, _fWidth = [transitionContext containerView].frame.size.width;
    // desc - top
    toVC.view.frame = CGRectMake(0, -_fHeight, _fWidth, _fHeight);
    // desc - left
//    toVC.view.frame = CGRectMake(-_fWidth, 0, _fWidth, _fHeight);
    // desc - bottom
//    toVC.view.frame = CGRectMake(0, _fHeight, _fWidth, _fHeight);
    // desc - right
//    toVC.view.frame = CGRectMake([transitionContext containerView].frame.size.width, 0, _fWidth, _fHeight);
    // desc - top-right
//    toVC.view.frame = CGRectMake(_fWidth, -_fHeight, _fWidth, _fHeight);
    // desc - top-left
//    toVC.view.frame = CGRectMake(-_fWidth, -_fHeight, _fWidth, _fHeight);
    // desc - top-left
//    toVC.view.frame = CGRectMake(-_fWidth, -_fHeight, _fWidth, _fHeight);
    // desc - bottom-right
//    toVC.view.frame = CGRectMake(_fWidth, _fHeight, _fWidth, _fHeight);
    // desc - bottom-left
//    toVC.view.frame = CGRectMake(-_fWidth, _fHeight, _fWidth, _fHeight);

    [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         toVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
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
