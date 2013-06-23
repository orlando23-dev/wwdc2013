//
//  SnapViewController.m
//  BasicUIDynamics
//
//  Created by ding orlando on 6/23/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "SnapViewController.h"

@interface SnapViewController ()

@property (nonatomic, weak) IBOutlet UIView* square;
@property (nonatomic) UIDynamicAnimator* animator;

@end

@implementation SnapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(IBAction)handleSnapGesture:(UITapGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:self.view];
    UISnapBehavior* beSnap = [[UISnapBehavior alloc]initWithItem:self.square snapToPoint:point];
    if (!self.animator) {
        UIDynamicAnimator* animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
        [animator addBehavior:beSnap];
        self.animator = animator;
    }
    else{
        [self.animator removeAllBehaviors];
        [self.animator addBehavior:beSnap];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
