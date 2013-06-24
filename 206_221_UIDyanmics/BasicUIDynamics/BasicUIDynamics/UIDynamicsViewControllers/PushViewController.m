//
//  PushViewController.m
//  BasicUIDynamics
//
//  Created by ding orlando on 6/24/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@property (nonatomic, weak) IBOutlet UIView* square;
@property (nonatomic, weak) IBOutlet UIView* vectorView;
@property (nonatomic) UIDynamicAnimator* animator;
@property (nonatomic) UIPushBehavior* pushBehavior;

@end

@implementation PushViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.category == Continuous) {
        self.title = @"Continuous Push";
    }
    self->_locationOfVectorview = self.vectorView.center;
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    // desc - collision behavior
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.square]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collisionBehavior];
    
    // desc - push behavior, a (100, 100) view to 100 p/s^2
    UIPushBehavior* pushBehavior = [[UIPushBehavior alloc]initWithItems:@[self.square]
                                                                   mode: (self.category == Continuous? UIPushBehaviorModeContinuous: UIPushBehaviorModeInstantaneous)];
    pushBehavior.angle = 0.0;
    pushBehavior.magnitude = 0.0;
    self.pushBehavior = pushBehavior;
    [animator addBehavior:pushBehavior];
    
    self.animator = animator;
    
    // desc - additional setup
//    self.vectorView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
//    NSLog(@"%f %f", self.vectorView.center.x, self.vectorView.center.y);
    self.vectorView.layer.anchorPoint = CGPointMake(0.0,0.0);
}

#pragma mark - gesture for instanenous push force

/*
 Tapping will change the angle and magnitude of the impulse. To visually show the impulse vector on screen, a red line representing the angle and magnitude of this vector is briefly drawn.
 */
- (IBAction)handleGesture:(UITapGestureRecognizer*)gesture{
    CGPoint p = [gesture locationInView:self.view];
    // reverse coordinate system
//    CGPoint o = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    CGPoint o = self->_locationOfVectorview;
    CGFloat distance = sqrtf(powf(p.x-o.x, 2.0)+powf(p.y-o.y, 2.0));
    CGFloat angle = atan2(p.y-o.y,p.x-o.x);
//    avoid too long push tracking
//    distance = MIN(distance, 100.0);
    
    // desc - animator
    self.vectorView.bounds = CGRectMake(0.0, 0.0, distance, 5.0);
    self.vectorView.transform = CGAffineTransformMakeRotation(angle);
    self.vectorView.alpha = 1.0;
    if (self.category == Instantaneous) {
        [UIView animateWithDuration:1.0 animations:^{
            self.vectorView.alpha = 0.0;
        }];
    }
    
    // desc - change of push
    // These two lines change the actual force vector.
    [self.pushBehavior setMagnitude:distance / 100.0];
    [self.pushBehavior setAngle:angle];
    /*
     A push behavior in instantaneous (impulse) mode automatically deactivate itself after applying the impulse. We thus need to reactivate it when changing the impulse vector.
     */
    if (self.category == Instantaneous) {
        [self.pushBehavior setActive:TRUE];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
