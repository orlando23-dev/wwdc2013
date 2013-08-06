//
//  AppDelegate.m
//  CoffeeMap
//
//  Created by llv22 on 8/6/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    // desc - show compass and zoom controls
    self.mapView.showsCompass = YES;
    self.mapView.showsZoomControls = YES;
    // desc - find the central location, show region (pairs)
    CLLocationCoordinate2D pairsCenterCoordinate = CLLocationCoordinate2DMake(48.86169450, 2.34107400);
    MKCoordinateRegion pairsRegion = MKCoordinateRegionMakeWithDistance(pairsCenterCoordinate, 10000, 10000);
    self.mapView.region = pairsRegion;
}

@end
