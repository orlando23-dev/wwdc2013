//
//  NavigatedViewController.m
//  CustomTransitions
//
//  Created by ding orlando on 7/2/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "NavigatedViewController.h"

@interface NavigatedViewController ()

@end

@implementation NavigatedViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Lonely Cypress";
    // http://stackoverflow.com/questions/7816972/how-can-i-set-image-directly-on-uiview
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
