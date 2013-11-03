//
//  AppDelegate.m
//  CameraViewOSX
//
//  Created by Ding Orlando on 11/3/13.
//  Copyright (c) 2013 Ding Orlando. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)updateCameraProperties{
    NSLog(@"%@", [self.mapView.camera description]);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self->animationCameras = [[NSMutableArray alloc]init];
    
    self.mapView.delegate = self;
    self.mapView.rotateEnabled = YES;
    self.mapView.showsCompass = YES;
    self.mapView.showsZoomControls = YES;
    
    // desc - center coordinate
    self.mapView.camera.centerCoordinate =  CLLocationCoordinate2DMake(37.78275123, -122.40416442);
    // desc - altitude - height above the map
    self.mapView.camera.altitude = 1500;
    // desc - heading - direction camera faces [0 - north for z axis, 180 - sourth for z axis, for z axis control]
    self.mapView.camera.heading = 0;
    // desc - pitch - angle camera tilts [0, 90], not make sense for (90, 180)
    self.mapView.camera.pitch = 30;
    
    [self updateCameraProperties];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    [self updateCameraProperties];
    if (animated) {
        [self goToNextCamera];
    }
}

- (void)goToNextCamera{
    if (animationCameras.count == 0) {
        //We've done!
        return;
    }
    
    MKMapCamera *nextCamera = [animationCameras firstObject];
    [animationCameras removeObjectAtIndex:0];
    // desc - don't use completionHandle of Animation
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 1.0;
        context.allowsImplicitAnimation = YES;
        CAMediaTimingFunction *f = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        context.timingFunction = f;
        self.mapView.camera = nextCamera;
    } completionHandler:NULL];
}

- (IBAction)performSearch:(NSSearchField *)searchField{
    NSString *searchQuery = [searchField stringValue];
    if (!searchQuery || searchQuery.length == 0) {
        return;
    }
    
    //desc - execute query for map on local region
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc]init];
    searchRequest.naturalLanguageQuery = searchQuery;
    searchRequest.region = self.mapView.region;
    
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:searchRequest];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (error || response.mapItems.count == 0) {
            NSLog(@"%@", error);
            return;
        }
        
        MKMapItem *topItem = [response.mapItems firstObject];
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self.mapView addAnnotation:topItem.placemark];
        // desc - not just move, but move here with 3D building
        [self.mapView showAnnotations:@[topItem.placemark] animated:YES];
    }];
}

@end
