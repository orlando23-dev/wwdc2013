//
//  ItemPropertiesViewController.m
//  BasicUIDynamics
//
//  Created by ding orlando on 6/24/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "ItemPropertiesViewController.h"

@interface ItemPropertiesViewController ()

@property (nonatomic, weak) IBOutlet UIView* leftSquare;
@property (nonatomic, weak) IBOutlet UIView* rightSquare;
@property (nonatomic) UIDynamicAnimator* animator;

@end

@implementation ItemPropertiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    /*
     We want to show collisions between views and boundaries with different elasticities, we thus associate the two views to gravity and collision behaviors. We will only change the restitution parameter for one of these views.
     */
    // desc - gravity and collision
    UIGravityBehavior* gravity = [[UIGravityBehavior alloc]initWithItems:@[self.leftSquare, self.rightSquare]];
    UICollisionBehavior* collision = [[UICollisionBehavior alloc]initWithItems:@[self.leftSquare, self.rightSquare]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // desc - for right item add item properities
    /*
     A dynamic item behavior gives access to low-level properties of an item in Dynamics, here we change restitution on collisions only for square2, and keep square1 with its default value.
     */
    UIDynamicItemBehavior* itemProperies = [[UIDynamicItemBehavior alloc]initWithItems:@[self.rightSquare]];
    itemProperies.elasticity = 0.5f;
    
    [animator addBehavior:gravity];
    [animator addBehavior:collision];
    [animator addBehavior:itemProperies];
    
    self.animator = animator;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
