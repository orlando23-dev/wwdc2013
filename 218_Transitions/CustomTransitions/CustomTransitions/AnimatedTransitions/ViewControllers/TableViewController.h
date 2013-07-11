//
//  ViewController.h
//  CustomTransitions
//
//  Created by ding orlando on 6/28/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NavigatedViewController;

@interface TableViewController : UITableViewController<UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>{
@private
    NavigatedViewController *_vc;
}

@end
