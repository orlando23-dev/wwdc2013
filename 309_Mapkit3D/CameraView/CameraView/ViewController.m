//
//  ViewController.m
//  CameraView
//
//  Created by llv22 on 8/18/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)updateCameraProperties{
    NSLog(@"%@", [self.mapView.camera description]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.camera.centerCoordinate =  CLLocationCoordinate2DMake(37.78275123, -122.40416442);
    self.mapView.camera.altitude = 1500;
    self.mapView.camera.pitch = 30;
    
    [self updateCameraProperties];
}

#pragma mark - camera update
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self updateCameraProperties];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
