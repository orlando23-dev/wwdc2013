//
//  NavigatedViewController.m
//  CustomTransitions
//
//  Created by ding orlando on 7/2/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "NavigatedViewController.h"
#import "ResourceUtil.h"

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
    // see http://stackoverflow.com/questions/7816972/how-can-i-set-image-directly-on-uiview
    UIImageView* imageView = [ResourceUtil navigateImage];
    
#ifdef TRACEUISIZE
    NSLog(@"[ImageView] x - %f, y - %f, width - %f, height - %f", imageView.bounds.origin.x, imageView.bounds.origin.y, imageView.bounds.size.width, imageView.bounds.size.height);
#endif
    
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
