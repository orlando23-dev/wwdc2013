//
//  GravityCollisionSpringViewController.m
//  BasicUIDynamics
//
//  Created by ding orlando on 6/24/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "GravityCollisionSpringViewController.h"

@interface GravityCollisionSpringViewController ()

@property (nonatomic, weak) IBOutlet UIView *square;
@property (nonatomic, weak) IBOutlet UIView *redSquare;
@property (nonatomic, weak) IBOutlet UIView *blueSquare;
@property (nonatomic) UIDynamicAnimator* animator;
@property (nonatomic) UIAttachmentBehavior* attachmentBehavior;

@end

@implementation GravityCollisionSpringViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior* gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[self.square]];
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.square]];
    
    CGPoint anchorPoint = CGPointMake(self.square.center.x, self.square.center.y - 100.0);
    UIAttachmentBehavior* attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.square attachedToAnchor:anchorPoint];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    // These parameters set the attachment in spring mode, instead of a rigid connection.
    [attachmentBehavior setFrequency:1.0];
    [attachmentBehavior setDamping:0.1];
    
    // Show the attachment points
    self.redSquare.center = attachmentBehavior.anchorPoint;
    self.blueSquare.center = CGPointMake(50.0, 50.0);
    
    [animator addBehavior:attachmentBehavior];
    [animator addBehavior:collisionBehavior];
    [animator addBehavior:gravityBeahvior];
    self.animator = animator;
    
    self.attachmentBehavior = attachmentBehavior;
}


-(IBAction)handleSpringAttachmentGesture:(UIPanGestureRecognizer*)gesture{
    [self.attachmentBehavior setAnchorPoint:[gesture locationInView:self.view]];
    self.redSquare.center = self.attachmentBehavior.anchorPoint;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
