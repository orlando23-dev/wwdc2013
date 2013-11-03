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
    // desc - center coordinate
    self.mapView.camera.centerCoordinate =  CLLocationCoordinate2DMake(37.78275123, -122.40416442);
    // desc - altitude - height above the map
    self.mapView.camera.altitude = 1500;
    // desc - heading - direction camera faces [0 - north for z axis, 180 - sourth for z axis, for z axis control]
    self.mapView.camera.heading = 0;
    // desc - pitch - angle camera tilts [0, 90], not make sense for (90, 180)
    self.mapView.camera.pitch = 30;
    
    /* 
     //desc - alternative for postion of camera
     CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(...);
     CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(...);
     MKMapCamera *myCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground
                                                    fromEyeCoordinate:eye
                                                    eyeAltitude:100];
     self.mapView.camera = myCamera;
     
     // desc - saving and restoring state of camera
     MKMapCamera *camera = self.mapView.camera;
     [NSKeyedArchiver archiveRootObject:camera toFile:stateFile];
     
     MKMapCamera *camera = [NSKeyedArchiver unarchiveObjectWithFile:stateFile];
     self.mapView.camera = camera;
    */
    
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
