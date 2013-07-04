//
//  NavigatedTransitionController.m
//  CustomTransitions
//
//  Created by ding orlando on 7/4/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "NavigatedTransitionController.h"

@implementation NavigatedTransitionController

- (void)slide:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    //    [[[transitionContext containerView] layer] setSublayerTransform:perspectiveTransform()];
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    
    toVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    toVC.view.layer.transform = CATransform3DMakeRotation(M_PI * 2,0.0,1.0,0.0); //flip halfway
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionFlipFromLeft
     //UIViewAnimationOptionCurveEaseIn
     //UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
                         fromVC.view.layer.transform = CATransform3DMakeRotation(M_PI * 2,0.0,1.0,0.0); //flip halfway
                     }
                     completion:^(BOOL finished){
                         //                         [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0f
                         //                                               delay:0.0f
                         //                                             options:UIViewAnimationOptionCurveEaseOut
                         //                                          animations:^{
                         //                                              toVC.view.layer.transform = CATransform3DMakeRotation(0.0f,0.0,1.0,0.0); //finish the flip
                         //                                          } completion:^(BOOL finished){
                         //                                              [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                         //                                          }];
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

- (void)spring:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    //    [[[transitionContext containerView] layer] setSublayerTransform:perspectiveTransform()];
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    
    toVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
//    toVC.view.layer.transform = CATransform3DMakeRotation(M_PI * 2,0.0,1.0,0.0); //flip halfway
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:1.2f
          initialSpringVelocity:1.4f
                        options:UIViewAnimationOptionTransitionFlipFromLeft
     //UIViewAnimationOptionCurveEaseIn
     //UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
//                         fromVC.view.layer.transform = CATransform3DMakeRotation(M_PI * 2,0.0,1.0,0.0); //flip halfway
                     }
                     completion:^(BOOL finished){
                         //                         [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0f
                         //                                               delay:0.0f
                         //                                             options:UIViewAnimationOptionCurveEaseOut
                         //                                          animations:^{
                         //                                              toVC.view.layer.transform = CATransform3DMakeRotation(0.0f,0.0,1.0,0.0); //finish the flip
                         //                                          } completion:^(BOOL finished){
                         //                                              [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                         //                                          }];
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

@end
