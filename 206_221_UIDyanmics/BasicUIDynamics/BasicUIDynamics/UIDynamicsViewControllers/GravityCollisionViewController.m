//
//  GravityCollisionViewController.m
//  BasicUIDynamics
//
//  Created by ding orlando on 6/22/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//
//  see: for more complex composition lowerSquare should be started anmiation before lowerSquare, then you
//      can see collision effect
//      1, upperSquare is hidden initially
//      2, lowerSquare will be flowing at the very begin, then upperSquare appears and flowing followed
//

#import "GravityCollisionViewController.h"

@interface GravityCollisionViewController () <UICollisionBehaviorDelegate>

@property (nonatomic, weak) IBOutlet UIView* upperSquare;
@property (nonatomic, weak) IBOutlet UIView* lowerSquare;
@property (nonatomic) UIDynamicAnimator* animator;

@end

@implementation GravityCollisionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // desc - record the initial color bitmap
    self->_colorOfLowerSquare = self.lowerSquare.backgroundColor;
    self->_colorOfUpperSquare = self.upperSquare.backgroundColor;
    // desc - animator
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    // desc - init for gravity and collision
    self->_behGravity = [[UIGravityBehavior alloc]initWithItems:@[self.lowerSquare]];
    self->_behCollision = [[UICollisionBehavior alloc]initWithItems:@[self.lowerSquare]];
    self->_behCollision.translatesReferenceBoundsIntoBoundary = YES;
    self->_behCollision.collisionDelegate = self;
    // desc - collision boundaries
//    [self->_behCollision addBoundaryWithIdentifier:@"Wall1" forPath:<Your Path>];
//    [self->_behCollision addBoundaryWithIdentifier:@"Wall2" fromPoint:<From Point> toPoint:<To Point>];
    [animator addBehavior:self->_behGravity];
    [animator addBehavior:self->_behCollision];
    self.animator = animator;
    
    [self performSelector:@selector(startFlowForUpper:) withObject:self.upperSquare afterDelay:0.2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startFlowForUpper: (id)upperSquare{
    self.upperSquare.hidden = NO;
    [self->_behGravity addItem:self.upperSquare];
    [self->_behCollision addItem:self.upperSquare];
}

#pragma mark - Collision boundary & Item delegates

// TODO : boundaryIdentifier will always return nil
- (void)collisionBehavior:(UICollisionBehavior*)behavior
      beganContactForItem:(id <UIDynamicItem>)item
   withBoundaryIdentifier:(id <NSCopying>)identifier
                  atPoint:(CGPoint)p{
    // Lighten the background color when the view is in contact with a boundary.
    if (item == self.lowerSquare&& self.lowerSquare.backgroundColor != [UIColor lightGrayColor]) {
        [self.lowerSquare setBackgroundColor:[UIColor lightGrayColor]];
    }
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior
     endedContactForItem:(id<UIDynamicItem>)item
  withBoundaryIdentifier:(id<NSCopying>)identifier{
    // Restore the default color when ending a contcact.
    if (item == self.lowerSquare && self.lowerSquare.backgroundColor != self->_colorOfLowerSquare) {
        [self.lowerSquare setBackgroundColor:self->_colorOfLowerSquare];
    }
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior
      beganContactForItem:(id <UIDynamicItem>)item1
                 withItem:(id <UIDynamicItem>)item2
                  atPoint:(CGPoint)p{
    if (item1 == self.upperSquare || item2 == self.upperSquare) {
        [self.upperSquare setBackgroundColor:[UIColor redColor]];
    }
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior
      endedContactForItem:(id <UIDynamicItem>)item1
                 withItem:(id <UIDynamicItem>)item2{
    if (item1 == self.upperSquare || item2 == self.upperSquare) {
        [self.upperSquare setBackgroundColor:self->_colorOfUpperSquare];
    }
}

@end
