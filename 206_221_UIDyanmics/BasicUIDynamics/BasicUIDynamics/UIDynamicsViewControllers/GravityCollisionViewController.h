//
//  GravityCollisionViewController.h
//  BasicUIDynamics
//
//  Created by ding orlando on 6/22/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <UIKit/UIKit.h>
@import UIKit;

@interface GravityCollisionViewController : UIViewController{
    @private
    UIGravityBehavior* _behGravity;
    UICollisionBehavior* _behCollision;
    UIColor* _colorOfLowerSquare;
    UIColor* _colorOfUpperSquare;
}

@end
