//
//  ViewController.h
//  CustomTransitions
//
//  Created by ding orlando on 6/28/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController<UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>{
    @private
        NSArray* _sections;
}

@end
