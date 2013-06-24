//
//  InstantPushViewController.h
//  BasicUIDynamics
//
//  Created by ding orlando on 6/24/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <UIKit/UIKit.h>
@import UIKit;

enum PushCategory{
    Instantaneous,
    Continuous
};

@interface PushViewController : UIViewController{
    @private
    CGPoint _locationOfVectorview;
}

@property (nonatomic) enum PushCategory category;

@end
