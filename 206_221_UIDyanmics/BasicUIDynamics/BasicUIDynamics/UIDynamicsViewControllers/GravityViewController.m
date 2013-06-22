//
//  GravityViewController.m
//  BasicUIDynamics
//
//  Created by ding orlando on 6/22/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "GravityViewController.h"

@interface GravityViewController ()

@property (nonatomic, weak) IBOutlet UIView* square;
@property (nonatomic) UIDynamicAnimator* animator;

@end

@implementation GravityViewController	

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UIGravityBehavior* gravity = [[UIGravityBehavior alloc]initWithItems:@[self.square]];
    // desc - (0, 1) by default, UIKit Gravity 1 g (9.8 m/s^2) = 1000 p/s^2, that's dx/dt, dy/dt
    gravity.xComponent = 0;
    gravity.yComponent = 0.5f;
    [animator addBehavior:gravity];
    self.animator = animator;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
