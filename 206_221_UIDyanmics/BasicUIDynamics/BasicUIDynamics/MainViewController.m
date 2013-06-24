//
//  MainViewController.m
//  BasicUIDynamics
//
//  Created by ding orlando on 6/24/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "MainViewController.h"
#import "PushViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

/* using default storyboard
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/**
 * see http://www.appcoda.com/storyboards-ios-tutorial-pass-data-between-view-controller-with-segue/
 **/
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Instantaneous"]) {
        ((PushViewController*)segue.destinationViewController).category = Instantaneous;
    }
    else if ([segue.identifier isEqualToString:@"Continuous"]) {
        ((PushViewController*)segue.destinationViewController).category = Continuous;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
